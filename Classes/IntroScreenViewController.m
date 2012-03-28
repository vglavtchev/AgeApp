//
//  IntroScreenViewController.m
//  Age Genie
//
//  Created by Jeff Ota on 3/27/12.
//  Copyright (c) 2012 NVIDIA. All rights reserved.
//

#import "IntroScreenViewController.h"

@implementation IntroScreenViewController

@synthesize hideIntro;

- (id) init
{
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)hideIntroView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideIntroView" object:self ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
