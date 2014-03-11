//
//  LearnViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/29/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "LearnViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "Model.h"
#import "AppDelegate.h"

@interface LearnViewController () <UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tutorialsTableView;
@property (nonatomic,strong) NSArray *allTutorials;
@property (nonatomic,strong) NSArray *allLinks;

@end

@implementation LearnViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"Tutorials_Loaded"
                                               object:nil];
    [self fetchDataFromParseObject];
    self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //We just need one section for now, might need more later
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if([Model sharedModel].tutorials != nil){
        return self.allTutorials.count;
    }
    [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"You need to have a proper network connection in order to read the tutorials." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    [(AppDelegate *)[UIApplication sharedApplication].delegate fetchTutorials];
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CGSize size = [[self.allTutorials objectAtIndex:indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Roman" size:14.0]}];
    cell.textLabel.numberOfLines = size.width/290.0 + 1;
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Roman" size:14.0]];
    cell.textLabel.text = [self.allTutorials objectAtIndex:indexPath.row];
    return cell;
}

#pragma  mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [[self.allTutorials objectAtIndex:indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Roman" size:14.0]}];
    return (size.width/290.0 + 1)*25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [DamnVulnerableAppUtilities pushWebVCWithURL:[self.allLinks objectAtIndex:indexPath.row] viewController:self];
}

-(void)fetchDataFromParseObject {
    NSString *tutorials = [[Model sharedModel].tutorials objectForKey:@"tutorials"];
    NSString *links = [[Model sharedModel].tutorials objectForKey:@"links"];
    self.allTutorials = [tutorials componentsSeparatedByString:@":"];
    self.allLinks = [links componentsSeparatedByString:@"::"];

}

-(void)reloadTable {
    [self fetchDataFromParseObject];
    [self.tutorialsTableView reloadData];
}

@end
