//
//  InsecureDataStorageVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "InsecureDataStorageVC.h"
#import "InsecureDataStorageVulnVC.h"
#import "UIViewController+ECSlidingViewController.h"
#import "Constants.h"

@interface InsecureDataStorageVC () 

@property (nonatomic,assign) NSInteger vulnCode;
@property (nonatomic,strong) NSArray *vulnerabilities;

- (IBAction)readArticleTapped:(id)sender;

@end

@implementation InsecureDataStorageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.vulnerabilities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.vulnerabilities objectAtIndex:indexPath.row];
    cell.textLabel.font = kCellFont;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.vulnCode = indexPath.row;
    [self performSegueWithIdentifier:@"pushInsecureVulnVC" sender:self];
  }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushInsecureVulnVC"]){
        InsecureDataStorageVulnVC *vc = segue.destinationViewController;
        vc.vulnCode = self.vulnCode;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    self.vulnerabilities = [NSArray arrayWithObjects:@"Plist",@"NSUserDefaults",@"Keychain",@"Core Data",@"Webkit Caching",@"Realm",@"Couchbase Lite",nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readArticleTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLLocalDataStorage viewController:self];
}
@end
