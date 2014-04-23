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
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Details", @"Details");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    CGSize new_size;
    new_size.height = self.contentView.bounds.size.height + self.navigationController.view.bounds.size.height;
    new_size.width = self.contentView.bounds.size.width;
    self.scrollView.contentSize = new_size;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // update view with information
    self.address.text = attendeeInfo.address;
    self.cgtServices.text = attendeeInfo.cgtServices;
    self.city.text = attendeeInfo.city;
    self.company.text = attendeeInfo.company;
    self.confId.text = attendeeInfo.confId;
    self.country.text = attendeeInfo.country;
    self.email.text = attendeeInfo.email;
    self.firstName.text = attendeeInfo.firstName;
    self.lastName.text = attendeeInfo.lastName;
    self.membership.text = attendeeInfo.membership;
    self.office.text = attendeeInfo.office;
    self.organization.text = attendeeInfo.organization;
    self.phone1.text = attendeeInfo.phone1;
    self.phone2.text = attendeeInfo.phone2;
    self.projectTimeframe.text = attendeeInfo.projectTimeframe;
    self.state.text = attendeeInfo.state;
    self.zipcode.text = attendeeInfo.zipcode;
    self.confName.text = attendeeInfo.confName;
    self.dateCreated.text = attendeeInfo.dateCreated;
    self.lykerNum.text = attendeeInfo.lykerNum;
    self.confName.text = attendeeInfo.confName;
    self.extraInfo.text = attendeeInfo.extraInfo;
}
@end
