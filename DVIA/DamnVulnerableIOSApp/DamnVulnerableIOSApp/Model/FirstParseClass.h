//
//  FirstParseClass.h
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 08.02.15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface FirstParseClass : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *keyword;

@end
