//
//  InsecureDataStorageVulnVC.h
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef enum {
    InsecureDataStoragePlist = 0,
    InsecureDataStorageUserDefaults,
    InsecureDataStorageKeychain,
    InsecureDataStorageCoreData,
    InsecureDataStorageWebKit,
    InsecureDataStorageRealm,
    InsecureDataStorageCouchbase,
    InsecureDataStorageYapDatabase
} InsecureVulnType;

@interface InsecureDataStorageVulnVC : UIViewController

@property (nonatomic,assign) NSInteger vulnCode;

@end
