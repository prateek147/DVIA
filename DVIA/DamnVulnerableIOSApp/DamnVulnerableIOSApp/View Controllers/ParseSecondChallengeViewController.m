//
//  ParseSecondChallengeViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "ParseSecondChallengeViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "SecondParseClass.h"

#import <Parse/Parse.h>

@interface ParseSecondChallengeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation ParseSecondChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self generatePersonalCode];
}

- (void)generatePersonalCode {
    NSString *identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSUInteger uniqueNumber = 0;
    
    for (int i = 0; i < identifier.length; i++) {
        int currentLetter = [identifier characterAtIndex:i];
        if (currentLetter % 2) {
            uniqueNumber += currentLetter;
        } else {
            uniqueNumber += currentLetter * 10;
        }
    }
    
    self.codeLabel.text = [NSString stringWithFormat:@"%li", uniqueNumber];
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've successfully added a new record to Parse!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Something got wrong, we haven't found a corresponding record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)testButtonTapped:(id)sender {
    PFQuery *query = [SecondParseClass query];
    
    [query whereKey:@"pentesterName" equalTo:self.nameTextField.text];
    [query whereKey:@"secretWord" equalTo:self.codeLabel.text];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            [self showSuccessAlert];
        } else {
            [self showFailureAlert];
        }
    }];
}

@end
