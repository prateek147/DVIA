//
//  RuntimeManipulationSuccessVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/1/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "RuntimeManipulationDetailsVC.h"
#import "DamnVulnerableAppUtilities.h"

@interface RuntimeManipulationDetailsVC ()

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic,strong) NSString *urlToLoad;

- (IBAction)readTutorialTapped:(id)sender;

@end

@implementation RuntimeManipulationDetailsVC

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
    self.urlToLoad = @"http://highaltitudehacks.com/2013/11/08/ios-application-security-part-21-arm-and-gdb-basics";
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginMethod1Tapped:(id)sender {
    if([self isLoginValidated]){
        [self pushSuccessPage];
    }else{
        [self showLoginFailureAlert];
    }
}

-(IBAction)loginMethod2Tapped:(id)sender {
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

-(BOOL)isLoginValidated {
    //I know this logic looks wierd, but you can still bypass this authorization check, trust me
    if(3 < 1){
        return YES;
    }
    return NO;
}

-(void)pushSuccessPage {
    [self performSegueWithIdentifier:@"pushSuccessPage" sender:self];
}

-(void)showLoginFailureAlert {
    [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Incorrect Username or Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (IBAction)readTutorialTapped:(id)sender {
[DamnVulnerableAppUtilities pushWebVCWithURL:self.urlToLoad viewController:self];
}

@end
