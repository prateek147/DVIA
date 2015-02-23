//
//  SecondParseClass.m
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import "SecondParseClass.h"

static NSString *const SecondParseClassName = @"ParseChallenge2";

@implementation SecondParseClass

@dynamic pentesterName;
@dynamic secretWord;

+ (NSString *)parseClassName {
    return SecondParseClassName;
}

+ (void)load {
    [self registerSubclass];
}

@end
