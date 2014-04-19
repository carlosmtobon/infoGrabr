//
//  QuestionnaireViewController.h
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/14/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionnaireServices;

@interface QuestionnaireViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger originalCount;
    QuestionnaireServices *sharedServices;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIPickerView *servicesPicker;

@property (strong, nonatomic) NSMutableArray *services;

@end
