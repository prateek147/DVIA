//
//  Model.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 3/11/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (Model *)sharedModel
{
    static Model *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[Model alloc] init];
        // Do any other initialisation stuff here
    });
    
    return sharedModel;
}

- (id)init
{
    self = [super init];
    if(self){
        //DO initialization stuff here
    }
    return self;
}

@end
