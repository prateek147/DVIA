//
//  SFAntiPiracy.m
//  
//
//  Created by Nick Kramer on 3/3/13.
//
//

// Import the Header
#import "SFAntiPiracy.h"

// Imports
#import <TargetConditionals.h>
#import <sys/stat.h>
#include <sys/sysctl.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>

@implementation SFAntiPiracy

#pragma mark - User Methods

//  Is the application pirated?
+ (int)isPirated {
    
    // Make sure the user is not a developer!!!
    #ifdef __i386__
        // It's the developer
        return NOTPIRATED;
    #elif TARGET_IPHONE_SIMULATOR
        // It's the developer
        return NOTPIRATED;
    #elif DEBUG
        // It's the developer
        return NOTPIRATED;
    #endif
    
    // First, let's check our honeypot checks (heheheh)
    if (![self isTheApplicationCracked])
        // It didn't return true, very suspicous ;)
        return KFHoneypot1;
    if (![self isTheDeviceJailbroken])
        // It didn't return true, very suspicous ;)
        return KFHoneypot2;
    if (![self isTheApplicationTamperedWith])
        // It didn't return true, very suspicous ;)
        return KFHoneypot3;
    
    // Now, let's verify our actual piracy checks
    
    // Make a piracy integer to count the number of failed checks
    int piracy = 0;
    
    // Run through 4 checks
    int sBinaryCheck = binaryEncryptionCheck();
    int sUserIDCheck = userIDCheck();
    int sCodeSigCheck = codeSignatureDirectoryCheck();
    int sFileManagerCheck = fileManagerCheck();
    
    // Verify the checks
    if (sBinaryCheck != NOTPIRATED)
        piracy += 1;
    if (sUserIDCheck != NOTPIRATED)
        piracy += 1;
    if (sCodeSigCheck != NOTPIRATED)
        piracy += 1;
    if (sFileManagerCheck != NOTPIRATED)
        piracy += 1;
    
    // Check the output of all checks
    if (piracy >= PIRACYTHRESHOLD)
        // Return Pirated Key
        return KFPirated;
    
    // If not, return Not Pirated Key
    return NOTPIRATED;
    
    // If it gets here, something went very wrong
    // Return Pirated
    return KFPirated;
}

// Is the application running on a jailbroken device?
+ (int)isJailbroken {
    // Is the device jailbroken?
    
    // Make an int to monitor how many checks are failed
    int motzart = 0;
    
    // URL Check
    if ([self urlCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 3;
    }
    
    // Cydia Check
    if ([self cydiaCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 3;
    }
    
    // Inaccessible Files Check
    if ([self inaccessibleFilesCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Plist Check
    if ([self plistCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Processes Check
    if ([self processesCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // FSTab Check
    if ([self fstabCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 1;
    }
    
    // Shell Check
    if ([self systemCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Symbolic Link Check
    if ([self symbolicLinkCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // FilesExist Integrity Check
    if ([self filesExistCheck] != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Check if the Jailbreak Integer is 3 or more
    if (motzart >= 3) {
        // Jailbroken
        return KFJailbroken;
    }
    
    // Not Jailbroken
    return NOTJAIL;
}

// Kill the application
+ (void)killApplication {
    // Try to run a system call for kill
    system(KILL);
    
    // SIGKILL
    [[UIApplication sharedApplication] sendAction:SIGKILL to:[UIApplication sharedApplication] from:self forEvent:nil];
    
    // Try an infinite while loop to gobble up memory
    int x = 0;
    NSMutableArray *haha = [[NSMutableArray alloc] init];
    while (1) {
        [haha addObject:@"42"];
        x++;
    }
    
    // If all else fails, close the app
    close(0);
}

#pragma mark - Static Piracy Checks

// Piracy Check 1 - Binary Encryption Check
static inline int binaryEncryptionCheck() {
    @try {
        // Define the header and dl info
        const struct mach_header *header;
        Dl_info dlinfo;
        
        // Define main
        int main (int argc, char *argv[]);
        
        // Fetch the dlinfo for main()
        if (dladdr(main, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
            // Unable to find main, something's wrong
            // Return Pirated
            return KFEFMS;
        }
        
        // Define the header
        header = dlinfo.dli_fbase;
        
        // Compute the image size and search for a UUID
        struct load_command *cmd = (struct load_command *) (header+1);
        
        // Run through a for loop of the encryption information
        for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
            /* Encryption info segment */
            if (cmd->cmd == LC_ENCRYPTION_INFO) {
                // Define the info from the crypt command
                struct encryption_info_command *crypt_cmd = (struct encryption_info_command *) cmd;
                // Check if binary encryption is enabled
                if (crypt_cmd->cryptid < 1) {
                    // Encryption information is invalid
                    // Return Pirated
                    return KFEncryption;
                }
                
                // Return Not Pirated
                return NOTPIRATED;
            }
            
            // Define the cmd
            cmd = (struct load_command *) ((uint8_t *) cmd + cmd->cmdsize);
        }
        /* Encryption info not found */
        // Pirated
        return KFEncryptInfo;
    }
    @catch (NSException *exception) {
        // Error
        return NOTPIRATED;
    }
}

// Piracy Check 2 - User ID Check
static inline int userIDCheck() {
    @try {
        // Check to see if the User ID is 0 (indicative of root user)
        if (getuid() == 0) {
            // Return Pirated
            return KFUserID;
        } else {
            // Return Not Pirated
            return NOTPIRATED;
        }
    }
    @catch (NSException *exception) {
        // Error
        return NOTPIRATED;
    }
}

// Piracy Check 3 - Code Signature Directory Check
static inline int codeSignatureDirectoryCheck() {
    @try {
        // Verify that user is using iOS 4.3 or less
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
            // User is on 4.3 or less
            
            // Get the path to the code signature directory
            NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
            
            // If the Code signature directory is there
            if ([FILECHECK [bundlePath stringByAppendingPathComponent:CODE_SIG]])
                // Return Not Pirated
                return NOTPIRATED;
            else
                // Return Pirated
                return KFCodeSig;
        } else {
            // User is on 5.0 or higher
            
            // Get the path to the code signature directory
            NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
            
            // Check if the PkgInfo file exists
            if ([FILECHECK [bundlePath stringByAppendingPathComponent:PKGINFO]])
                // Return Not pirated
                return NOTPIRATED;
            else
                // Return Pirated
                return KFPkgCheck;
        }
    }
    @catch (NSException *exception) {
        // Error
        return NOTPIRATED;
    }
}

// Piracy Check 4 - Patched NSFileManager Check
static inline int fileManagerCheck() {
    // Make sure the File Checking System isn't patched
    
    // Check if the executable file exists (it should)
    if (![FILECHECK EXEPATH]) {
        // File system is patched!
        return KFFileEXE;
    }
    
    // Check if the info.plist file exists (it should)
    NSDictionary *dict = PLISTPATH;
    if (dict.count < 1) {
        // NSFileManager is patched!
        return KFPlistCheck;
    }
    
    // Nothing happened, assume the best
    return NOTPIRATED;
}

// Honeypot checks, throwing them off ;) - Hehehe

// Is the device jailbroken?  Always TRUE
+ (BOOL)isTheDeviceJailbroken {
    return YES;
}

// Is the application pirated?  Always TRUE
+ (BOOL)isTheApplicationCracked {
    return YES;
}

// Is the application tampered with?  Always TRUE
+ (BOOL)isTheApplicationTamperedWith {
    return YES;
}

#pragma mark - Static Jailbreak Checks

// UIApplication CanOpenURL Check
+ (int)urlCheck {
    @try {
        // Create a fake url for cydia
        NSURL *FakeURL = [NSURL URLWithString:CYDIAPACKAGE];
        // Return whether or not cydia's openurl item exists
        if ([[UIApplication sharedApplication] canOpenURL:FakeURL])
            return KFOpenURL;
        else
            return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Cydia Check
+ (int)cydiaCheck {
    @try {
        // Create a file path string
        NSString *filePath = CYDIALOC;
        // Check if it exists
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            // It exists
            return KFCydia;
        } else {
            // It doesn't exist
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Inaccessible Files Check
+ (int)inaccessibleFilesCheck {
    @try {
        // Run through the array of files
        for (NSString *key in HIDDENFILES) {
            // Check if any of the files exist (should return no)
            if ([[NSFileManager defaultManager] fileExistsAtPath:key]) {
                // Jailbroken
                return KFIFC;
            }
        }
        
        // Shouldn't get this far, return jailbroken
        return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Plist Check
+ (int)plistCheck {
    @try {
        // Define the Executable name
        NSString *ExeName = EXEPATH;
        NSDictionary *ipl = PLISTPATH;
        // Check if the plist exists
        if ([FILECHECK ExeName] == FALSE || ipl == nil || ipl.count <= 0) {
            // Executable file can't be found and the plist can't be found...hmmm
            return KFPlist;
        } else {
            // Everything is good
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Running Processes Check
+ (int)processesCheck {
    @try {
        // Make a processes array
        NSArray *processes = [self runningProcesses];
        
        // Check for Cydia in the running processes
        for (NSDictionary * dict in processes) {
            // Define the process name
            NSString *process = [dict objectForKey:@"ProcessName"];
            // If the process is this executable
            if ([process isEqualToString:CYDIA]) {
                // Return Jailbroken
                return KFProcessesCydia;
            } else if ([process isEqualToString:OTHERCYDIA]) {
                // Return Jailbroken
                return KFProcessesOtherCydia;
            } else if ([process isEqualToString:OOCYDIA]) {
                // Return Jailbroken
                return KFProcessesOtherOCydia;
            }
        }
        
        // Not Jailbroken
        return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Error
        return NOTJAIL;
    }
}

// FSTab Size
+ (int)fstabCheck {
    @try {
        struct stat sb;
        stat("/etc/fstab", &sb);
        long long size = sb.st_size;
        if (size == 80) {
            // Not jailbroken
            return NOTJAIL;
        } else
            // Jailbroken
            return KFFSTab;
    }
    @catch (NSException *exception) {
        // Not jailbroken
        return NOTJAIL;
    }
}

// System() available
+ (int)systemCheck {
    @try {
        // See if the system call can be used
        if (system(0)) {
            // Jailbroken
            return KFSystem;
        } else
            // Not Jailbroken
            return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Not Jailbroken
        return NOTJAIL;
    }
}

// Symbolic Link available
+ (int)symbolicLinkCheck {
    @try {
        // See if the Applications folder is a symbolic link
        struct stat s;
        if (lstat("/Applications", &s) != 0) {
            if (s.st_mode & S_IFLNK) {
                // Device is jailbroken
                return KFSymbolic;
            } else
                // Not jailbroken
                return NOTJAIL;
        } else {
            // Not jailbroken
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Not Jailbroken
        return NOTJAIL;
    }
}

// FileSystem working correctly?
+ (int)filesExistCheck {
    @try {
        // Check if filemanager is working
        if (![FILECHECK [[NSBundle mainBundle] executablePath]]) {
            // Jailbroken and trying to hide it
            return KFFileExists;
        } else
            // Not Jailbroken
            return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Not Jailbroken
        return NOTJAIL;
    }
}

// Get the running processes
+ (NSArray *)runningProcesses {
    // Define the int array of the kernel's processes
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    // Make a new size and int of the sysctl calls
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    // Make new structs for the processes
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    // Do get all the processes while there are no errors
    do {
        // Add to the size
        size += size / 10;
        // Get the new process
        newprocess = realloc(process, size);
        // If the process selected doesn't exist
        if (!newprocess){
            // But the process exists
            if (process){
                // Free the process
                free(process);
            }
            // Return that nothing happened
            return nil;
        }
        
        // Make the process equal
        process = newprocess;
        
        // Set the st to the next process
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    // As long as the process list is empty
    if (st == 0){
        
        // And the size of the processes is 0
        if (size % sizeof(struct kinfo_proc) == 0){
            // Define the new process
            int nprocess = size / sizeof(struct kinfo_proc);
            // If the process exists
            if (nprocess){
                // Create a new array
                NSMutableArray * array = [[NSMutableArray alloc] init];
                // Run through a for loop of the processes
                for (int i = nprocess - 1; i >= 0; i--){
                    // Get the process ID
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    // Get the process Name
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    // Get the process Priority
                    NSString *processPriority = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_priority];
                    // Get the process running time
                    NSDate   *processStartDate = [NSDate dateWithTimeIntervalSince1970:process[i].kp_proc.p_un.__p_starttime.tv_sec];
                    // Create a new dictionary containing all the process ID's and Name's
                    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processPriority, processName, processStartDate, nil]
                                                                       forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessPriority", @"ProcessName", @"ProcessStartDate", nil]];
                    
                    // Add the dictionary to the array
                    [array addObject:dict];
                }
                // Free the process array
                free(process);
                
                // Return the process array
                return array;
                
            }
        }
    }
    // If no processes are found, return nothing
    return nil;
}

@end
