//
//  AttackingParseViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "AttackingParseViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface AttackingParseViewController ()

@end

@implementation AttackingParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readArticleButtonTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleParse viewController:self];
}

@end
