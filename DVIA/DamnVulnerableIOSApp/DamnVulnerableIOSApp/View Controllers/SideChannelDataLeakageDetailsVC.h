//
//  SensitiveInformationDisclosureDetailsVC.h
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/12/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SensInfoLogs = 0,
    SensInfoScreenshot,
    SensInfoPasteboard,
    SensInfoKeystrokeLogging,
} SensInfoVulnType;

@interface SideChannelDataLeakageDetailsVC : UIViewController


@property (nonatomic,assign) NSInteger vulnCode;

@end
