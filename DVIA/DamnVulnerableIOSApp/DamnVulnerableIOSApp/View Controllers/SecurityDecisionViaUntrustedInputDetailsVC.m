//
//  SecurityDecisionsViaUntrustedInputDetailsVC.m
//  DamnVulnerableIOSApp
//
//  Created by Prateek Gianchandani on 2/11/14.
//  Copyright (c) 2014 HighAltitudeHacks.com. All rights reserved.
//

#import "SecurityDecisionViaUntrustedInputDetailsVC.h"

@interface SecurityDecisionsViaUntrustedInputDetailsVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *callStatusLabel;
@property (weak, nonatomic) IBOutlet UITextField *callNoTextField;

- (IBAction)readArticleTapped:(id)sender;

@end

@implementation SecurityDecisionsViaUntrustedInputDetailsVC

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
    [self.scrollView setContentSize:CGSizeMake(320.0, 700.0)];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callButtonTapped:(id)sender {
    [self.callStatusLabel setHidden:NO];
    if(self.callNoTextField.text.length != 0){
        [self.callStatusLabel setText:[NSString stringWithFormat:@"Calling %@. Ring Ring !!",self.callNoTextField.text]];
    }
    
}

- (IBAction)readArticleTapped:(id)sender {
    [DamnVulnerableAppUtilities pushWebVCWithURL:kArticleURLSchemes viewController:self];
}
@end
