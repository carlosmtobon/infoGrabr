//
//  QuestionnaireViewController.h
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/14/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionnaireServices;
@class Attendee;

@interface QuestionnaireViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    QuestionnaireServices *sharedServices;
    Attendee *clientLead;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIPickerView *servicesPicker;

@property (strong, nonatomic) NSMutableArray *services;

@property (strong, nonatomic) NSMutableArray *timeframes;

@property (strong, nonatomic) UITextField *timeFramePickerView;

@property (strong, nonatomic) Attendee *clientLead;

- (IBAction)saveButton:(id)sender;

- (IBAction)timeFrameDropDown:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *confID;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *organization;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UITextField *company;
@property (strong, nonatomic) IBOutlet UITextField *office;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *zipcode;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *membership;
@property (strong, nonatomic) IBOutlet UITextField *phoneOne;
@property (strong, nonatomic) IBOutlet UITextField *phoneTwo;
@property (strong, nonatomic) IBOutlet UITextField *email;

@end
