#import <Foundation/Foundation.h>
#import "Attendee.h"

@interface InfoGrabrJSON : NSObject
+ (void)fetchServices: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler;
+ (void)fetchConferences: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler;
+ (NSData *)fetchServicesSync;
+ (NSData *)fetchAttendeesSync;
+ (BOOL)pushAttendeeSync:(NSString *)info;

@end
