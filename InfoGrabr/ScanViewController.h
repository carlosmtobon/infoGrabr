//
//  ScanViewController.h
//  InfoGrabr
//
//  Created by Charles on 4/11/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ZXingWidgetController.h>

@interface ScanViewController : UIViewController <ZXingDelegate>

- (IBAction)scanPressed:(id)sender;

@end
