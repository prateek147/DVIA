//
//  AppleWatchConfigurationViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 19/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "AppleWatchConfigurationViewController.h"
#import <Parse/Parse.h>
#include <stdlib.h>

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface AppleWatchConfigurationViewController ()

@end

@implementation AppleWatchConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNewRandomBankUser];
}

- (void)createNewRandomBankUser {
    PFObject *bankUser = [PFObject objectWithClassName:@"AppleWatchBankUser"];
    bankUser[@"cardNumber"] = [self randomCardNumber];
    bankUser[@"moneyBalance"] = [self randomBalance];
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

@end
