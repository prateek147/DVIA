//
//  SensitiveInformationDisclosureDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/12/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SensitiveInformationDisclosureDetailsVC.h"

@interface SensitiveInformationDisclosureDetailsVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *vulnerabilities;

@end

@implementation SensitiveInformationDisclosureDetailsVC

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

@end
