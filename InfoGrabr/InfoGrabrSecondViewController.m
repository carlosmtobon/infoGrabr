//
//  InfoGrabrSecondViewController.m
//  InfoGrabr
//
//  Created by Charles on 4/10/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "InfoGrabrSecondViewController.h"

@interface InfoGrabrSecondViewController ()

@end

@implementation InfoGrabrSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
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
