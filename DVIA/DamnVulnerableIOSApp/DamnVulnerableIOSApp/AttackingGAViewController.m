//
//  AttackingGAViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 18/05/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "AttackingGAViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface AttackingGAViewController ()

@end

@implementation AttackingGAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
