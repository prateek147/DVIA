//
//  ClientSideInjectionVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/4/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "ClientSideInjectionVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface ClientSideInjectionVC ()

@end

@implementation ClientSideInjectionVC

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readArticleTapped:(id)sender {
}

@end
