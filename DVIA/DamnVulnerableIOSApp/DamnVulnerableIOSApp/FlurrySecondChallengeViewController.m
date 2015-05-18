//
//  FlurrySecondChallengeViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 17/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "FlurrySecondChallengeViewController.h"
#import "UIViewController+ECSlidingViewController.h"

#import "Flurry.h"

static NSString *const FlurrySecretEventName = @"damnVulnerableFlurryEvent";

@interface FlurrySecondChallengeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *secretNameTextField;

@end

@implementation FlurrySecondChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *challengeParams = @{
                                      @"eventSecretName" : FlurrySecretEventName
                                      };
    [Flurry logEvent:@"SecondFlurryChallenge" withParameters:challengeParams];
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the right secret phrase!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Well, your answer is not right." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)testResultButtonTapped:(id)sender {
    NSString *keyword = FlurrySecretEventName;
    NSString *userInput = self.secretNameTextField.text;
    if ([keyword isEqualToString:userInput]) {
        [self showSuccessAlert];
    } else {
        [self showFailureAlert];
    }
}



@end
