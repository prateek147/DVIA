//
//  User.h
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;

@end
