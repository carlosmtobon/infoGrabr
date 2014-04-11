//
//  ScanViewController.m
//  InfoGrabr
//
//  Created by Charles on 4/11/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "ScanViewController.h"

#import <MultiFormatReader.h>

@interface ScanViewController ()

@end

@implementation ScanViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanPressed:(id)sender {
    
    ZXingWidgetController* zxingWidgetController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    zxingWidgetController.readers = [[NSSet alloc] initWithObjects:[[MultiFormatReader alloc] init], nil];
    NSBundle* mainBundle = [NSBundle mainBundle];
    zxingWidgetController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:zxingWidgetController animated:YES completion:nil];

}

-(void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    NSLog(@"%@", result);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
