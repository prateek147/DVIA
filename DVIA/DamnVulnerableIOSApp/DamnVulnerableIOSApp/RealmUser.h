//
//  RealmUser.h
//  DamnVulnerableIOSApp
//
//  Created by Egor Tolstoy on 2/27/15.
//  Copyright (c) 2015 HighAltitudeHacks.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmUser : RLMObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *password;

@end
