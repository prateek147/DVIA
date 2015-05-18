//
//  SensitiveInformationDisclosureDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/12/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SideChannelDataLeakageDetailsVC.h"

static NSString *const SiteURLString = @"http://highaltitudehacks.com";
static NSString *const CookieUsername = @"admin123";
static NSString *const CookiePassword = @"dvpassword";

@interface SideChannelDataLeakageDetailsVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *cookiesView;
@property (weak, nonatomic) IBOutlet UITextField *cookiesUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cookiesPasswordTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *logsView;
@property (weak, nonatomic) IBOutlet UIScrollView *screenshotView;
@property (weak, nonatomic) IBOutlet UIScrollView *pasteboardView;
@property (weak, nonatomic) IBOutlet UIScrollView *keystrokeView;
@property (nonatomic,strong) NSArray *vulnerabilities;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)signUpTapped:(id)sender;

@end

@implementation SideChannelDataLeakageDetailsVC

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
    [self.screenshotView setContentSize:CGSizeMake(320.0, 700.0)];
    [self.pasteboardView setContentSize:CGSizeMake(320.0, 700.0)];
    [self.keystrokeView setContentSize:CGSizeMake(320.0, 700.0)];
    [self.cookiesView setContentSize:CGSizeMake(320.0, 700.0)];

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
        case SensInfoKeystrokeLogging:
            [self.keystrokeView setHidden:NO];
            break;
        case SensInfoCookies:
            [self.cookiesView setHidden:NO];
            [self setSharedCookies];
            break;
        default:
            break;
    }
	// Do any additional setup after loading the view.
}

- (void)setSharedCookies {
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    [components setMonth:components.month + 5];
    NSDate *expireDate = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    NSTimeInterval expireInterval = [expireDate timeIntervalSince1970];
    
    NSURL *siteURL = [NSURL URLWithString:SiteURLString];
    NSDictionary *usernameProperties = @{
                                 NSHTTPCookieDomain : siteURL.host,
                                 NSHTTPCookiePath : siteURL.path,
                                 NSHTTPCookieName : @"username",
                                 NSHTTPCookieValue : CookieUsername,
                                 NSHTTPCookieExpires : @(expireInterval)
                                 };
    NSHTTPCookie *usernameCookie = [[NSHTTPCookie alloc] initWithProperties:usernameProperties];
    
    NSDictionary *passwordProperties = @{
                                         NSHTTPCookieDomain : siteURL.host,
                                         NSHTTPCookiePath : siteURL.path,
                                         NSHTTPCookieName : @"password",
                                         NSHTTPCookieValue : CookiePassword,
                                         NSHTTPCookieExpires : @(expireInterval)
                                         };
    NSHTTPCookie *passwordCookie = [[NSHTTPCookie alloc] initWithProperties:passwordProperties];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:@[usernameCookie, passwordCookie] forURL:siteURL mainDocumentURL:nil];
}

-(void)makeSignUpCall {
    [self.signUpButton setTitle:@"Signing Up ..." forState:UIControlStateNormal];
    PFObject *user = [PFObject objectWithClassName:@"Person"];
    user[@"name"] = self.nameTextField.text;
    user[@"password"] = self.passwordTextField.text;
    user[@"phone"] = self.phoneNoTextField.text;
    user[@"email"] = self.emailTextField.text;
    NSLog(@"user saved: %@", user.description);
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        if(succeeded){
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"User signed up successfully, look for the logs now" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            NSLog(@"Saved user info: %@",user.description);
            
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cookiesTestResultsButtonTapped:(id)sender {
    NSString *inputtedUsername = self.cookiesUsernameTextField.text;
    NSString *inputtedPassword = self.cookiesPasswordTextField.text;
    
    BOOL isRightUsername = [inputtedUsername isEqualToString:CookieUsername];
    BOOL isRightPassword = [inputtedPassword isEqualToString:CookiePassword];
    
    if (isRightUsername && isRightPassword) {
        [self showSuccessAlert];
    } else {
        [self showFailureAlert];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signUpTapped:(id)sender {
    [self makeSignUpCall];
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the right username and password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Well, your answer is not right." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
