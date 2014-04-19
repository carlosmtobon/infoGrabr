//
//  Attendee.h
//  InfoGrabr
//
//  Created by Charles on 4/19/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conference;

@interface Attendee : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cgtServices;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * confId;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * extraInfo;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * membership;
@property (nonatomic, retain) NSString * office;
@property (nonatomic, retain) NSString * organization;
@property (nonatomic, retain) NSString * phone1;
@property (nonatomic, retain) NSString * phone2;
@property (nonatomic, retain) NSString * projectTimeframe;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zipcode;
@property (nonatomic, retain) Conference *conf;

@end
