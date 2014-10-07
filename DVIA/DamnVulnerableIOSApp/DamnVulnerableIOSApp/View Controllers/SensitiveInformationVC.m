//
//  SensitiveInformationVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 10/7/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SensitiveInformationVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface SensitiveInformationVC ()

@end

@implementation SensitiveInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
