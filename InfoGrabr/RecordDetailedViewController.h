//
//  RecordDetailedViewController.h
//  InfoGrabr
//
//  Created by enio pena navarro on 4/21/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attendee.h"

@interface RecordDetailedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel * address;
@property (weak, nonatomic) IBOutlet UILabel * cgtServices;
@property (weak, nonatomic) IBOutlet UILabel * city;
@property (weak, nonatomic) IBOutlet UILabel * company;
@property (weak, nonatomic) IBOutlet UILabel * confId;
@property (weak, nonatomic) IBOutlet UILabel * country;
@property (weak, nonatomic) IBOutlet UILabel * email;
@property (weak, nonatomic) IBOutlet UILabel * firstName;
@property (weak, nonatomic) IBOutlet UILabel * lastName;
@property (weak, nonatomic) IBOutlet UILabel * membership;
@property (weak, nonatomic) IBOutlet UILabel * office;
@property (weak, nonatomic) IBOutlet UILabel * organization;
@property (weak, nonatomic) IBOutlet UILabel * phone1;
@property (weak, nonatomic) IBOutlet UILabel * phone2;
@property (weak, nonatomic) IBOutlet UILabel * projectTimeframe;
@property (weak, nonatomic) IBOutlet UILabel * state;
@property (weak, nonatomic) IBOutlet UILabel * zipcode;
@property (weak, nonatomic) IBOutlet UILabel * confName;
@property (weak, nonatomic) IBOutlet UILabel * dateCreated;
@property (weak, nonatomic) IBOutlet UILabel * lykerNum;
@property (weak, nonatomic) IBOutlet UITextView *extraInfo;

@property (strong, nonatomic) Attendee *attendeeInfo;

@end
