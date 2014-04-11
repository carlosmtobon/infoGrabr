//
//  InfoGrabrFirstViewController.m
//  InfoGrabr
//
//  Created by Charles on 4/10/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "InfoGrabrFirstViewController.h"

@interface InfoGrabrFirstViewController ()

@end

@implementation InfoGrabrFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
