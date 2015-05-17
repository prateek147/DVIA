//
//  InsecureDataStorageVulnVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "InsecureDataStorageVulnVC.h"
#import "PDKeychainBindings.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "User.h"
#import <Realm/Realm.h>
#import "RealmUser.h"

@interface InsecureDataStorageVulnVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *userDefaultsView;
@property (weak, nonatomic) IBOutlet UIView *keychainView;
@property (weak, nonatomic) IBOutlet UIView *plistView;
@property (weak, nonatomic) IBOutlet UIView *coreDataView;
@property (weak, nonatomic) IBOutlet UIView *webkitView;
@property (weak, nonatomic) IBOutlet UIView *realmView;
@property (weak, nonatomic) IBOutlet UIView *couchbaseView;


@property (strong, nonatomic) IBOutlet UITextField *userDefaultsTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *keychainTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *realmUserName;
@property (weak, nonatomic) IBOutlet UITextField *realmPassword;

@property (weak, nonatomic) IBOutlet UITextField *couchbaseUserName;
@property (weak, nonatomic) IBOutlet UITextField *couchbasePassword;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveInUserDefaultsTapped:(id)sender;
- (IBAction)saveInPlistFileTapped:(id)sender;
- (IBAction)saveInKeychainTapped:(id)sender;
- (IBAction)saveInCoreDataTapped:(id)sender;

@end

@implementation InsecureDataStorageVulnVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    switch (self.vulnCode) {
        case InsecureDataStoragePlist:
            [self.plistView setHidden:NO];
            break;
        case InsecureDataStorageUserDefaults:
            [self.userDefaultsView setHidden:NO];
            break;
        case InsecureDataStorageKeychain:
            [self.keychainView setHidden:NO];
            break;
        case InsecureDataStorageCoreData:
            [self.coreDataView setHidden:NO];
            break;
        case InsecureDataStorageWebKit:
            [self.webkitView setHidden:NO];
            break;
        case InsecureDataStorageRealm:
            [self.realmView setHidden:NO];
            break;
        case InsecureDataStorageCouchbase:
            [self.couchbaseView setHidden:NO];
            break;
        default:
            break;
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveInUserDefaultsTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userDefaultsTextField.text forKey:@"DemoValue"];
    [defaults synchronize];
    [DamnVulnerableAppUtilities showAlertWithMessage:@"Data saved in NSUserDefaults"];
}

- (IBAction)saveInPlistFileTapped:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/userInfo.plist"];
    NSMutableDictionary* plist = [[NSMutableDictionary alloc] init];
    [plist setValue:self.usernameTextField.text forKey:@"username"];
    [plist setValue:self.passwordTextField.text forKey:@"password"];
    [plist writeToFile:filePath atomically:YES];
    [DamnVulnerableAppUtilities showAlertWithMessage:@"Data saved in Plist"];
}

- (IBAction)saveInKeychainTapped:(id)sender {
    PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];
    [bindings setObject:self.keychainTextField.text forKey:@"keychainValue"];
    [DamnVulnerableAppUtilities showAlertWithMessage:@"Data saved in Keychain"];
}

- (IBAction)saveInCoreDataTapped:(id)sender {
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                  inManagedObjectContext:self.managedObjectContext];
    newUser.name = self.nameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.phone = self.phoneTextField.text;
    newUser.password = self.userPasswordTextField.text;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in saving data: %@", [error localizedDescription]);
        [DamnVulnerableAppUtilities showAlertWithMessage:@"Error Saved in Core Data"];
        
    }else{
        [DamnVulnerableAppUtilities showAlertWithMessage:@"Data saved in Core Data"];
    }
}

- (IBAction)saveInRealmTapped:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    RealmUser *user = [[RealmUser alloc] init];
    
    user.name = self.realmUserName.text;
    user.password = self.realmPassword.text;
    
    [realm beginWriteTransaction];
    [realm addObject:user];
    [realm commitWriteTransaction];
}

- (IBAction)saveInCouchbaseTapped:(id)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
