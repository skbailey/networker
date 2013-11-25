//
//  SKBDetailViewController.m
//  Networker
//
//  Created by Sherard Bailey on 11/24/13.
//  Copyright (c) 2013 shbailey63. All rights reserved.
//

#import "SKBDetailViewController.h"

@interface SKBDetailViewController ()

@end

@implementation SKBDetailViewController

@synthesize albumTitle;

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
    self.albumTitle.text = self.title;
    [self.albumTitle sizeToFit];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
