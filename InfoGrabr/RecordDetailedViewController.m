//
//  RecordDetailedViewController.m
//  InfoGrabr
//
//  Created by enio pena navarro on 4/21/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "RecordDetailedViewController.h"
#import "Attendee.h"

@implementation RecordDetailedViewController
@synthesize attendeeInfo;

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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.address setText:@"Test"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
