//
//  GAFirstChallengeViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 18/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "GAFirstChallengeViewController.h"
#import "GoogleAnalytics/GAI.h"

static NSString *const GoogleAnalyticsApiKey = @"UA-63106875-1";

@interface GAFirstChallengeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;

@end

@implementation GAFirstChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the Google Analytics API Key! Now you can proceed to the following challenge." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Well, your answer is not right." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)testButtonTapped:(id)sender {
    NSString *keyword = GoogleAnalyticsApiKey;
    NSString *userInput = self.apiKeyTextField.text;
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
