//
//  SensitiveInformationDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 10/7/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SensitiveInformationDetailsVC.h"

@interface SensitiveInformationDetailsVC ()

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;

@end

@implementation SensitiveInformationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username = @"Bobby";
    self.password = @"P2ssw0rd";
    [self initializeLogin];
    // Do any additional setup after loading the view.
}

-(void)initializeLogin {
    //DO random stuff
    NSString *passwd = @"MYw0r1d1821";
    //Finish doing random stuff
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
