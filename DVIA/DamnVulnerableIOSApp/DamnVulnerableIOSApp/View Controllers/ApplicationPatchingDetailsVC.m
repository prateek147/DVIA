//
//  ApplicationPatchingDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/1/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "ApplicationPatchingDetailsVC.h"

@interface ApplicationPatchingDetailsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
-(IBAction)jailbreakTestTapped:(id)sender;

@end

@implementation ApplicationPatchingDetailsVC

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
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginMethod1Tapped:(id)sender {
    BOOL didLogin = NO;
    //Heeyy, you shouldn't be looking at the source code !!
    if(([self.usernameTextField.text isEqualToString:@"Admin"] && [self.passwordTextField.text isEqualToString:@"This!sA5Ecret"])){
        didLogin = YES;
    }
    if(didLogin){
        [self pushSuccessPage];
    }else{
        [self showLoginFailureAlert];
    }
}

-(void)pushSuccessPage {
    [self performSegueWithIdentifier:@"pushSuccessPage" sender:self];
}


-(IBAction)jailbreakTestTapped:(id)sender{
if (!TARGET_IPHONE_SIMULATOR){
    BOOL isJailbroken = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
        isJailbroken = YES;
    }
    
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        //Device is jailbroken
        isJailbroken = YES;
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        //Device is jailbroken
        isJailbroken = YES;
    }
    [DamnVulnerableAppUtilities showAlertForJailbreakTestIsJailbroken:isJailbroken];
    
}else{
    //User is not testing on a device
    [DamnVulnerableAppUtilities showAlertForJailbreakTestIsJailbroken:NO];
 }
}

-(void)showLoginFailureAlert {
    [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Incorrect Username or Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (IBAction)showAlertTapped:(id)sender {
     [[[UIAlertView alloc] initWithTitle:nil message:@"I love Google" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
