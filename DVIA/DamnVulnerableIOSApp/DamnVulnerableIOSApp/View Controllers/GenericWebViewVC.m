//
//  GenericWebViewVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 12/30/13.
//  Copyright (c) 2013 HighAltitudeHacks.com. All rights reserved.
//

#import "GenericWebViewVC.h"

@interface GenericWebViewVC () <UIWebViewDelegate>

@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation GenericWebViewVC

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
    [DamnVulnerableAppUtilities addCommonBackgroundImageToViewController:self];
    [self loadWebPage];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWebPage {
    self.webView.delegate = self;
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidden = NO;
    self.activityIndicator.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Please check your network connection!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

@end
