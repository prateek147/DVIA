//
//  SFAntiPiracy.h
//  Shmoopi Anti-Piracy Free
//
//  Created by Shmoopi LLC on 3/3/13.
//  Copyright (c) 2013 Shmoopi LLC.  All rights reserved.
//

#import <UIKit/UIKit.h>

/* These are the NOT Pirated and NOT Jailbroken Keys.  These keys 
 will be returned from the pirated and jailbreak checks. They are
 returned only if the device is not jailbroken and the app is not
 pirated. Any other return value should be treated as 
 pirated/jailbroken. It's a good idea to change these keys before
 releasing your application!
*/
#define NOTPIRATED  6284382
#define NOTJAIL     4783242

/* Set the piracy threshold for absolute certainty
 that the application is pirated. The threshold
 indicates how many checks can fail before you 
 decide the application is pirated.
 Maximum threshold is 4 failed piracy checks,
 Minimum threshold is 1 failed piracy checks.
 Default is 1.
*/
#define PIRACYTHRESHOLD 1

@interface SFAntiPiracy : NSObject

//  Is the application pirated?
+ (int)isPirated;

// Is the application running on a jailbroken device?
+ (int)isJailbroken;

// Kill the application
+ (void)killApplication;

@end

// Failed piracy checks
enum {
    // Failed the Piracy Check
    KFPirated = 994832,
    // Failed the Encryption Finding Main Symbol Check
    KFEFMS = 102937,
    // Failed the Encryption Check
    KFEncryption = 11291,
    // Failed Finding Encryption Info
    KFEncryptInfo = 77632,
    // Failed the User ID Check
    KFUserID = 392823,
    // Failed the CodeSig Check
    KFCodeSig = 3823492,
    // Failed the PkgInfo Check
    KFPkgCheck = 112203,
    // Failed FileManager EXE Check
    KFFileEXE = 271721,
    // Failed FileManager Plist Check
    KFPlistCheck = 32532,
    // Failed Honeypot Check 1
    KFHoneypot1 = 845834,
    // Failed Honeypot Check 2
    KFHoneypot2 = 845835,
    // Failed Honeypot Check 3
    KFHoneypot3 = 845836,
} PiratedChecks;
// Failed jailbroken checks
enum {
    // Failed the Jailbreak Check
    KFJailbroken = 3429542,
    // Failed the OpenURL Check
    KFOpenURL = 321,
    // Failed the Cydia Check
    KFCydia = 432,
    // Failed the Inaccessible Files Check
    KFIFC = 47293,
    // Failed the plist check
    KFPlist = 9412,
    // Failed the Processes Check with Cydia
    KFProcessesCydia = 10012,
    // Failed the Processes Check with other Cydia
    KFProcessesOtherCydia = 42932,
    // Failed the Processes Check with other other Cydia
    KFProcessesOtherOCydia = 10013,
    // Failed the FSTab Check
    KFFSTab = 9620,
    // Failed the System() Check
    KFSystem = 47475,
    // Failed the Symbolic Link Check
    KFSymbolic = 34859,
    // Failed the File Exists Check
    KFFileExists = 6625,
} JailbrokenChecks;

/* Piracy Check Definitions */

// Define the encryption information (if needed)
#if TARGET_IPHONE_SIMULATOR && !defined(LC_ENCRYPTION_INFO)
#define LC_ENCRYPTION_INFO 0x21
struct encryption_ianfo_command {
    uint32_t cmd;
    uint32_t cmdsize;
    uint32_t cryptoff;
    uint32_t cryptsize;
    uint32_t cryptid;
};
#endif

// Code Signature and PkgInfo Definitions
#define CODE_SIG    @"_CodeSignature"
#define PKGINFO     @"PkgInfo"

// Create static functions
static int binaryEncryptionCheck() __attribute__((always_inline));
static int userIDCheck() __attribute__((always_inline));
static int codeSignatureDirectoryCheck() __attribute__((always_inline));
static int fileManagerCheck() __attribute__((always_inline));

/* End Piracy Check Definitions */

/* Jailbreak Check Definitions */

// Define the filesystem check
#define FILECHECK [NSFileManager defaultManager] fileExistsAtPath:
// Define the exe path
#define EXEPATH [[NSBundle mainBundle] executablePath]
// Define the plist path
#define PLISTPATH [[NSBundle mainBundle] infoDictionary]

// Jailbreak Check Definitions
#define CYDIA       @"MobileCydia"
#define OTHERCYDIA  @"Cydia"
#define OOCYDIA     @"afpd"
#define CYDIAPACKAGE    @"cydia://package/com.fake.package"
#define CYDIALOC        @"/Applications/Cydia.app"
#define HIDDENFILES     [NSArray arrayWithObjects:@"/Applications/RockApp.app",@"/Applications/Icy.app",@"/usr/sbin/sshd",@"/usr/bin/sshd",@"/usr/libexec/sftp-server",@"/Applications/WinterBoard.app",@"/Applications/SBSettings.app",@"/Applications/MxTube.app",@"/Applications/IntelliScreen.app",@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",@"/private/var/lib/apt",@"/private/var/stash",@"/System/Library/LaunchDaemons/com.ikey.bbot.plist",@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",@"/private/var/tmp/cydia.log",@"/private/var/lib/cydia", @"/etc/clutch.conf", @"/var/cache/clutch.plist", @"/etc/clutch_cracked.plist", @"/var/cache/clutch_cracked.plist", @"/var/lib/clutch/overdrive.dylib", @"/var/root/Documents/Cracked/", nil]

// Create static functions
static int urlCheck() __attribute__((always_inline));
static int cydiaCheck() __attribute__((always_inline));
static int inaccessibleFilesCheck() __attribute__((always_inline));
static int plistCheck() __attribute__((always_inline));
static int processesCheck() __attribute__((always_inline));
static int fstabCheck() __attribute__((always_inline));
static int systemCheck() __attribute__((always_inline));
static int symbolicLinkCheck() __attribute__((always_inline));
static int filesExistCheck() __attribute__((always_inline));

/* End Jailbreak Definitions */

// Kill System Call Definition
#define KILL "killall SpringBoard"
