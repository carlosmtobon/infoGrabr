//
//  QuestionnaireViewController.h
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/12/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnaireViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong,nonatomic)IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic)IBOutlet UIView *contentView;

//- (void)textFieldDidBeginEditing:(UITextField *)textField;


@end
