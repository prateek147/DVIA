//
//  TransportLayerProtectionVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/2/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "TransportLayerProtectionVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface TransportLayerProtectionVC () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *cardNoField;
@property (strong, nonatomic) IBOutlet UITextField *cardOwnerNameField;
@property (strong, nonatomic) IBOutlet UITextField *cardCVVfield;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation TransportLayerProtectionVC

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
     self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.mainScrollView setContentSize:CGSizeMake(320.0, 700.0)];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readArticleTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLTransportLayer viewController:self];
}

- (IBAction)sendOverHTTPTapped:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://google.com/"];
    
    [self sendRequestOverUrl:url];
}

- (IBAction)sendOverHTTPSTapped:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://google.com/"];
    
    [self sendRequestOverUrl:url];
}

-(void)sendRequestOverUrl:(NSURL *)url {
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url      standardizedURL]];
    [request setHTTPMethod:@"POST"];
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:self.cardNoField.text, @"card_number",
                              self.cardOwnerNameField.text, @"card_name",self.cardCVVfield.text,@"card_cvv", nil];
    NSError *error=nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                       options:NSJSONWritingPrettyPrinted     error:&error];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //start the connection
    [connection start];
    
    [DamnVulnerableAppUtilities showAlertWithMessage:@"Request Sent, lookout !"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
