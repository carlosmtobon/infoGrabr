//
//  AttendeeStore.h
//  InfoGrabr
//
//  Created by Carlos Tobon on 4/13/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Attendee.h"
#import "Conference.h"

@interface AttendeeStore : NSObject

@property (nonatomic, strong) Conference* currentConference;
@property (nonatomic, strong) NSMutableArray* allConferences;
@property (nonatomic, strong) NSManagedObjectContext* ctx;
@property (nonatomic, strong) NSManagedObjectModel* model;

-(NSString*) getStorePath;
-(void) loadAllConferences;
-(BOOL) save;
-(Conference*) createConference;
-(Attendee*) createAttendee;
-(void) removeAttendee:(Attendee*) attendee;

@end
