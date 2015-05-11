//
//  AttackingFlurryViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 11.05.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "AttackingFlurryViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface AttackingFlurryViewController ()

@end

@implementation AttackingFlurryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
