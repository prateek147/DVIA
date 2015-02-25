//
//  ParseFirstChallengeViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "ParseFirstChallengeViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "FirstParseClass.h"

#import <Parse/Parse.h>

@interface ParseFirstChallengeViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ParseFirstChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the right keyword! You can proceed forward to the challenge 2." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

- (IBAction)testButtonTapped:(id)sender {
    PFQuery *query = [FirstParseClass query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        FirstParseClass *object = [objects firstObject];
        NSString *keyword = object.keyword;
        NSString *userInput = self.inputTextField.text;
        if ([keyword isEqualToString:userInput]) {
            [self showSuccessAlert];
        } else {
            [self showFailureAlert];
        }
    }];
}

@end
