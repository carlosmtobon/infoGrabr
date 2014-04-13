//
//  Conference.h
//  InfoGrabr
//
//  Created by Carlos Tobon on 4/13/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Attendee;

@interface Conference : NSManagedObject

@property (nonatomic, retain) NSString * confName;
@property (nonatomic, retain) NSDate * confDate;
@property (nonatomic, retain) NSSet *attendees;
@end

@interface Conference (CoreDataGeneratedAccessors)

- (void)addAttendeesObject:(Attendee *)value;
- (void)removeAttendeesObject:(Attendee *)value;
- (void)addAttendees:(NSSet *)values;
- (void)removeAttendees:(NSSet *)values;

@end
