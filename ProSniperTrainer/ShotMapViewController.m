//
//  ShotMapViewController.m
//  ProSniperTrainer
//
//  Created by Nikki Fernandez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShotMapViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShotMapViewController

@synthesize addRoundButton;
@synthesize deleteRoundButton;
@synthesize settingsButton;
@synthesize sniperButton;
@synthesize shotMapScrollView;
@synthesize shotMap1ImageView;
@synthesize shotMap2ImageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"Shot Map";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    shotMapScrollView.contentSize = CGSizeMake(640.0, 365.0);

    shotMap1ImageView.frame = CGRectMake(0.0, 0.0, 321.0, 365.0);
    [shotMapScrollView addSubview:shotMap1ImageView];
    shotMap2ImageView.frame = CGRectMake(321.0, 0.0, 320.0, 365.0);
    [shotMapScrollView addSubview:shotMap2ImageView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Scroll View delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark Navigation Button events

-(IBAction) addRoundClicked
{
    
}

-(IBAction) deleteRoundClicked
{
    
}

-(IBAction) settingsClicked
{
    
}

-(IBAction) sniperClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
