//
//  TransportLayerProtectionVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/2/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "TransportLayerProtectionVC.h"
#import "UIViewController+ECSlidingViewController.h"

@interface TransportLayerProtectionVC () <UITextFieldDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UITextField *cardNoField;
@property (strong, nonatomic) IBOutlet UITextField *cardOwnerNameField;
@property (strong, nonatomic) IBOutlet UITextField *cardCVVfield;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,assign) BOOL isSSLPinning;

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

- (IBAction)sendUsingSSLPinning:(id)sender {
    self.isSSLPinning = YES;
    NSURL *httpsURL = [NSURL URLWithString:@"https://www.google.co.uk"];
    NSURLRequest *request = [NSURLRequest requestWithURL:httpsURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0f];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   //Ignore
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //Ignore
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    self.isSSLPinning = NO;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    //Don't check for valid certificate when the user taps on "Send over HTTPs"
    if(self.isSSLPinning){
    self.isSSLPinning = NO;
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
    NSData *remoteCertificateData = CFBridgingRelease(SecCertificateCopyData(certificate));
    NSData *skabberCertData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"google.co.uk" ofType:@"cer"]];
    
    if ([remoteCertificateData isEqualToData:skabberCertData]) {
        [DamnVulnerableAppUtilities showAlertWithMessage:@"Request Sent using pinning, lookout !"];
         NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
    else {
        [DamnVulnerableAppUtilities showAlertWithMessage:@"Certificate validation failed. You will have to do better than this, my boy!!"];
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    }
}
@end
