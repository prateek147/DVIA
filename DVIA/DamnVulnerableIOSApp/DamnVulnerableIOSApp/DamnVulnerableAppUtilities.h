//
//  DamnVulnerableAppUtilities.h
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DamnVulnerableAppUtilities : NSObject

+(void)pushWebVCWithURL:(NSString *)url viewController:(UIViewController *)viewController;
+(void)showAlertForJailbreakTestIsJailbroken:(BOOL)isJaibroken;
+(void)showAlertWithMessage:(NSString *)message;
+(void)addCommonBackgroundImageToViewController:(UIViewController *)viewController;

@end
