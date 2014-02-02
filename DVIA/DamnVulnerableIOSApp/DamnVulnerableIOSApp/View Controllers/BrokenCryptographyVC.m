//
//  BrokenCryptographyVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/6/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "BrokenCryptographyVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface BrokenCryptographyVC ()

@end

@implementation BrokenCryptographyVC

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
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
	// Do any additional setup after loading the view.
}

- (IBAction)readArticleTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLBrokenCryptography viewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
