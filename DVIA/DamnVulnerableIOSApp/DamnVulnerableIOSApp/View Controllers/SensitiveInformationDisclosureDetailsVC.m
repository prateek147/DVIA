//
//  SensitiveInformationDisclosureDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/12/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SensitiveInformationDisclosureDetailsVC.h"

@interface SensitiveInformationDisclosureDetailsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *logsView;
@property (weak, nonatomic) IBOutlet UIView *screenshotView;
@property (weak, nonatomic) IBOutlet UIView *pasteboardView;
@property (nonatomic,strong) NSArray *vulnerabilities;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)signUpTapped:(id)sender;

@end

@implementation SensitiveInformationDisclosureDetailsVC

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
    [self.logsView setContentSize:CGSizeMake(320.0, 700.0)];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    switch (self.vulnCode) {
        case SensInfoLogs:
            [self.logsView setHidden:NO];
            break;
        case SensInfoPasteboard:
            [self.pasteboardView setHidden:NO];
            break;
        case SensInfoScreenshot:
            [self.screenshotView setHidden:NO];
            break;
        default:
            break;
    }
	// Do any additional setup after loading the view.
}

-(void)makeSignUpCall {
    PFObject *user = [PFObject objectWithClassName:@"Person"];
    user[@"name"] = self.nameTextField.text;
    user[@"password"] = self.passwordTextField.text;
    user[@"phone"] = self.phoneNoTextField.text;
    user[@"email"] = self.emailTextField.text;
    NSLog(@"user saved: %@", user.description);
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Saved user info: %@",user.description);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signUpTapped:(id)sender {
    [self makeSignUpCall];
}
@end
