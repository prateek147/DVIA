//
//  ApplicationPatchingVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/1/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "ApplicationPatchingVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface ApplicationPatchingVC ()

@end

@implementation ApplicationPatchingVC

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

- (IBAction)readArticle1Tapped:(id)sender {
     [DamnVulnerableAppUtilities pushWebVCWithURL:kArticlePatchingApplication1 viewController:self];
}

- (IBAction)readArticle2Tapped:(id)sender {
     [DamnVulnerableAppUtilities pushWebVCWithURL:kArticlePatchingApplication2 viewController:self];
}

@end
