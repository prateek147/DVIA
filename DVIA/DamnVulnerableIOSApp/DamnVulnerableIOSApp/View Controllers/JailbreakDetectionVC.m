//
//  JailbreakDetectionVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/31/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "JailbreakDetectionVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface JailbreakDetectionVC ()

@end

@implementation JailbreakDetectionVC

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readArticleTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLJailbreakDetection viewController:self];
    
}

- (IBAction)jailbreakTest1Tapped:(id)sender {
    [DamnVulnerableAppUtilities showAlertForJailbreakTestIsJailbroken:[self isJailbroken]];
}

- (IBAction)jailbreakTest2Tapped:(id)sender {
    if (!TARGET_IPHONE_SIMULATOR){
    BOOL isJailbroken = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
        isJailbroken = YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
        isJailbroken = YES;
    }
    
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        //Device is jailbroken
        isJailbroken = YES;
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        //Device is jailbroken
        isJailbroken = YES;
    }
     [DamnVulnerableAppUtilities showAlertForJailbreakTestIsJailbroken:isJailbroken];
    
    }else{
        //User is not testing on a device
        [DamnVulnerableAppUtilities showAlertForJailbreakTestIsJailbroken:NO];
    }
}


-(BOOL)isJailbroken{
    
#if !(TARGET_IPHONE_SIMULATOR)
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
        return YES;
    }
    
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        //Device is jailbroken
        return YES;
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        //Device is jailbroken
        return YES;
    }
#endif
    
    //All checks have failed. Most probably, the device is not jailbroken
    return NO;
}


@end
