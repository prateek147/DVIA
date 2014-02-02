//
//  LearnViewController.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/29/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "LearnViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface LearnViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

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
     self.navigationController.navigationBar.tintColor = kNavigationTintColor;
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    [self loadWebPage];
	// Do any additional setup after loading the view.
}

-(void)loadWebPage {
    self.webView.delegate = self;
   self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidden = NO;
    self.activityIndicator.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:kLearnIOSSecurityURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.location=\"twitter://post?message=visit%20maniacdev.com\""];
    //  [webView stringByEvaluatingJavaScriptFromString:@"alert('asdasdasda');"];
    // [webView stringByEvaluatingJavaScriptFromString:@"document.location=\"mailto://foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!\""];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.location=\"sms://1-408-555-1212\""];
    //[webView stringByEvaluatingJavaScriptFromString:@"document.location=\"tel://1-408-555-5555\""];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Please check your network connection!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
