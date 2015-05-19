//
//  AppleWatchConfigurationViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 19/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "AppleWatchFirstChallengeViewController.h"
#import <Parse/Parse.h>
#include <stdlib.h>

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface AppleWatchFirstChallengeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;

@property (strong, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSNumber *cvvCode;

@end

@implementation AppleWatchFirstChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNewRandomBankUser];
    
    self.infoLabel.text = [NSString stringWithFormat:@"Input the CVV code for credit card with number %@:", self.cardNumber];
}

- (IBAction)testButtonTapped:(id)sender {
    NSString *keyword = self.cvvCode;
    NSString *userInput = self.cvvTextField.text;
    if ([keyword isEqualToString:userInput]) {
        [self showSuccessAlert];
    } else {
        [self showFailureAlert];
    }
}

- (void)showSuccessAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Congrats! You've found the right CVV code! Now you can proceed to the following challenge." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showFailureAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Well, your answer is not right." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)createNewRandomBankUser {
    PFObject *bankUser = [PFObject objectWithClassName:@"AppleWatchBankUser"];
    self.cardNumber = [self randomCardNumber];
    self.cvvCode = [self randomBalance];
    
    bankUser[@"cardNumber"] = self.cardNumber;
    bankUser[@"moneyBalance"] = self.cvvCode;
    bankUser[@"cvvCode"] = [self randomCvvCode];
    
    [bankUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

- (NSString *)randomCardNumber {
    NSUInteger cardNumber = RAND_FROM_TO(1000000000000000, 2000000000000000);
    return [NSString stringWithFormat:@"%li", cardNumber];
}

- (NSNumber *)randomBalance {
    return @(RAND_FROM_TO(100, 200));
}

- (NSNumber *)randomCvvCode {
    return @(RAND_FROM_TO(100, 999));
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
