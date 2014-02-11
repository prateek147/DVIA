//
//  SecurityDescisionViaUntrustedInputVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/11/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SecurityDecisionViaUntrustedInputVC.h"

@interface SecurityDecisionViaUntrustedInputVC ()


@end

@implementation SecurityDecisionViaUntrustedInputVC

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
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
