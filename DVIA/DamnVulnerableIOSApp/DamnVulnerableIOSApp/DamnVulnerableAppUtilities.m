//
//  DamnVulnerableAppUtilities.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "DamnVulnerableAppUtilities.h"
#import "GenericWebViewVC.h"

@implementation DamnVulnerableAppUtilities

+(void)pushWebVCWithURL:(NSString *)url viewController:(UIViewController *)viewController{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:[NSBundle mainBundle]];

    GenericWebViewVC *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GenericWebViewVC"];
    vc.url = url;
    vc.navigationItem.title = viewController.navigationItem.title;
    [viewController.navigationController pushViewController:vc animated:YES];
    
}

+(void)showAlertForJailbreakTestIsJailbroken:(BOOL)isJaibroken {
    if(isJaibroken){
        [[[UIAlertView alloc] initWithTitle:Nil message:@"Device is Jailbroken" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:Nil message:@"Device is Not Jailbroken" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

+(void)showAlertWithMessage:(NSString *)message {
        [[[UIAlertView alloc] initWithTitle:Nil message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

+(void)addCommonBackgroundImageToViewController:(UIViewController *)viewController{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-bg"]];
    bgImageView.frame = viewController.view.bounds;
    [viewController.view addSubview:bgImageView];
    [viewController.view sendSubviewToBack:bgImageView];
}


@end
