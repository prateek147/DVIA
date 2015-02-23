//
//  FirstParseClass.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "FirstParseClass.h"

static NSString *const FirstParseClassName = @"ParseChallenge1";

@implementation FirstParseClass

@dynamic keyword;

+ (NSString *)parseClassName {
    return FirstParseClassName;
}

+ (void)load {
    [self registerSubclass];
}

@end
