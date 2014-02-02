//
//  BrokenCryptographyDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/6/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "BrokenCryptographyDetailsVC.h"
#import "PDKeychainBindings.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"

@interface BrokenCryptographyDetailsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *firstUserView;
@property (weak, nonatomic) IBOutlet UIView *returningUserView;
@property (weak, nonatomic) IBOutlet UITextField *returningUserTextField;
@property (weak, nonatomic) IBOutlet UILabel *returningUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *loggedInLabel;

@end

@implementation BrokenCryptographyDetailsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkUserState];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)encryptAndSaveInKeychainTapped:(id)sender {
    [self.passwordTextField resignFirstResponder];
    NSData *data = [self.passwordTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *encryptedData = [RNEncryptor encryptData:data
                                        withSettings:kRNCryptorAES256Settings
                                            password:self.passwordTextField.text
                                               error:&error];
    PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];
    [bindings setObject:[[NSString alloc] initWithData:encryptedData
                                                                  encoding:NSUTF8StringEncoding] forKey:@"password_brokenCrypt"];
    [DamnVulnerableAppUtilities showAlertWithMessage:@"Data saved in Keychain"];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/secret-data"];
    
    if(textField == self.passwordTextField){
        [textField resignFirstResponder];
        if(textField.text.length == 0){
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please enter a password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return NO;
        }
        NSData *data = [self.passwordTextField.text dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSData *encryptedData = [RNEncryptor encryptData:data
                                            withSettings:kRNCryptorAES256Settings
                                                password:@"Secret-Key"
                                                   error:&error];
        
        [encryptedData writeToFile:dataPath atomically:YES];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.firstUserView setHidden:YES];
        
    }
    else if(textField == self.returningUserTextField){
        
        NSData *data = [self.returningUserTextField.text dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSData *encryptedData = [NSData dataWithContentsOfFile:dataPath];
        NSData *decryptedData = [RNDecryptor decryptData:encryptedData
                                            withPassword:@"Secret-Key"
                                                   error:&error];
        
        if([data isEqualToData:decryptedData]){
            [self.loggedInLabel setHidden:NO];
            [self.returningUserTextField setHidden:YES];
            [self.returningUserLabel setHidden:YES];
            
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Password is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return NO;
            
        }
    }
    
    return NO;
}

-(void)checkUserState {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"]){
        [self.firstUserView setHidden:YES];
    }
}



@end
