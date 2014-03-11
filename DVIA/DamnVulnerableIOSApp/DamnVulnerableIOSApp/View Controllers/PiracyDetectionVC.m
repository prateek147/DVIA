//
//  PiracyDetectionVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 3/11/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "PiracyDetectionVC.h"
#import "SFAntiPiracy.h"

@interface PiracyDetectionVC ()

- (IBAction)checkForPiracy:(id)sender;

@end

@implementation PiracyDetectionVC

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)checkForPiracy:(id)sender {
    if([SFAntiPiracy isPirated]){
        [[[UIAlertView alloc] initWithTitle:nil message:@"The application is pirated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:nil message:@"The application is not pirated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }

}
@end
