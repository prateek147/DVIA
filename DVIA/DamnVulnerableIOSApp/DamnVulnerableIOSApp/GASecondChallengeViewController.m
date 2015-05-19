//
//  GASecondChallengeViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 18/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "GASecondChallengeViewController.h"
#import "GoogleAnalytics/GAI.h"
#import "GoogleAnalytics/GAIDictionaryBuilder.h"
#import "UIViewController+ECSlidingViewController.h"

static NSString *const GASecretEventName = @"damnVulnerableGoogleEvent";

@interface GASecondChallengeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *secretEventValueTextField;

@end

@implementation GASecondChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"DVIA Events"
                                                          action:@"eventSecrenAction"
                                                           label:GASecretEventName
                                                           value:nil] build]];
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the right secret phrase!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Well, your answer is not right." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)testButtonTapped:(id)sender {
    NSString *keyword = GASecretEventName;
    NSString *userInput = self.secretEventValueTextField.text;
    if ([keyword isEqualToString:userInput]) {
        [self showSuccessAlert];
    } else {
        [self showFailureAlert];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
