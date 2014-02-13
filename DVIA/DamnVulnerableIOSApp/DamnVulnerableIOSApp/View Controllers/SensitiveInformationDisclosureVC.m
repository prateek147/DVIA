//
//  SensitiveInformationDisclosureVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/12/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SensitiveInformationDisclosureVC.h"
#import "SensitiveInformationDisclosureDetailsVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface SensitiveInformationDisclosureVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *vulnerabilities;
@property (nonatomic,assign) NSInteger vulnCode;

@end

@implementation SensitiveInformationDisclosureVC

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
     self.vulnerabilities = [NSArray arrayWithObjects:@"Device Logs",@"App Screenshot",@"Pasteboard",@"Keystroke logging",nil];
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
     self.navigationController.navigationBar.tintColor = kNavigationTintColor;
	// Do any additional setup after loading the view.
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
    [self performSegueWithIdentifier:@"pushSensInfoDetailsVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushSensInfoDetailsVC"]){
        SensitiveInformationDisclosureDetailsVC *vc = segue.destinationViewController;
        vc.vulnCode = self.vulnCode;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
