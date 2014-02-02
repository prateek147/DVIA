//
//  ClientSideInjectionDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 1/4/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "ClientSideInjectionDetailsVC.h"

@interface ClientSideInjectionDetailsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ClientSideInjectionDetailsVC

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.webView loadHTMLString:[NSString stringWithFormat:@"Hello %@! \n I am inside a UIWebView !",textField.text] baseURL:nil];
    [textField resignFirstResponder];
    return NO;
}


@end
