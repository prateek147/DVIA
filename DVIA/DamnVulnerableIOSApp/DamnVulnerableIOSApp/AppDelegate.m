//
//  AppDelegate.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/29/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Flurry/Flurry.h"
#import "Model.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header-bg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //Initialize parse
    [Parse setApplicationId:kParseAppId
                  clientKey:kParseClientKey];
    
    //Initialize Flurry
    [Flurry startSession:@"ZMSFBDBYFQ8XHQBRP2VY"];
    
    [self fetchTutorials];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{   NSString *urlString = [url absoluteString];
    if (!([urlString rangeOfString:@"/call_number/"].location == NSNotFound)) {
        NSDictionary *param = [self getParameters:url];
        if([param objectForKey:@"phone"]!= nil){
            [[[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"Calling %@ without validation. Ring Ring !",[param objectForKey:@"phone"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        return YES;
      }
    return NO;
}

//Converts parameters from url into NSDictionary
-(NSDictionary*) getParameters:(NSURL*)url{
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    NSString *urlString = [url absoluteString];
    NSArray *components = [urlString componentsSeparatedByString:@"?"];
    NSString *query = [components lastObject];
    NSArray *queryElements = [query componentsSeparatedByString:@"&"];
    for (NSString *element in queryElements) {
        NSArray *keyVal = [element componentsSeparatedByString:@"="];
        if (keyVal.count > 0) {
            NSString *variableKey = [keyVal objectAtIndex:0];
            NSString *value = (keyVal.count == 2) ? [keyVal lastObject] : nil;
            if(variableKey!=nil && value!=nil)
                [parameters setObject:value forKey:variableKey];
        }
    }
    return parameters;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data methods

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"CoreData.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

-(void)fetchTutorials{
    PFQuery *query = [PFQuery queryWithClassName:@"Tutorials"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"K4VnZubvAs" block:^(PFObject *tutorials, NSError *error) {
        [[Model sharedModel] setTutorials:tutorials];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Tutorials_Loaded" object:self];
        
    }];

}

@end
