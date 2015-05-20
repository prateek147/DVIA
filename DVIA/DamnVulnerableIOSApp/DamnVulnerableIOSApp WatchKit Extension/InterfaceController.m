//
//  InterfaceController.m
//  DamnVulnerableIOSApp WatchKit Extension
//
//  Created by Egor Tolstoy on 18/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *cardBalanceLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self updateData];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)refreshDataButtonTapped {
    [self updateData];
}

- (void)updateData {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.dvia.AppleWatch.shared"];
    NSString *cardNumber = [defaults objectForKey:@"cardNumber"] ?: @"undefined";
    NSNumber *balance = [defaults objectForKey:@"moneyBalance"] ?: @0;
    [self.cardNumberLabel setText:cardNumber];
    [self.cardBalanceLabel setText:[NSString stringWithFormat:@"%@$", balance]];
}

@end



