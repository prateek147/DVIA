//
//  Model.h
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 3/11/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic,strong) PFObject *tutorials;
+ (Model *)sharedModel;

@end
