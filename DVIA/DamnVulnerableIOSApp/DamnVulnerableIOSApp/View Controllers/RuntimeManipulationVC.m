//
//  RuntimeManipulationVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/1/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "RuntimeManipulationVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface RuntimeManipulationVC ()

- (IBAction)runtimeTutorial1Tapped:(id)sender;
- (IBAction)runtimeTutorial2Tapped:(id)sender;
- (IBAction)runtimeTutorial3Tapped:(id)sender;
- (IBAction)runtimeTutorial4Tapped:(id)sender;
- (IBAction)runtimeTutorial5Tapped:(id)sender;
- (IBAction)runtimeTutorial6Tapped:(id)sender;
- (IBAction)runtimeTutorial7Tapped:(id)sender;

@end

@implementation RuntimeManipulationVC

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
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runtimeTutorial1Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime1 viewController:self];
}

- (IBAction)runtimeTutorial2Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime2 viewController:self];
}

- (IBAction)runtimeTutorial3Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime3 viewController:self];
}

- (IBAction)runtimeTutorial4Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime4 viewController:self];
}

- (IBAction)runtimeTutorial5Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime5 viewController:self];
}

- (IBAction)runtimeTutorial6Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime6 viewController:self];
}

- (IBAction)runtimeTutorial7Tapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLRuntime7 viewController:self];
}

@end
