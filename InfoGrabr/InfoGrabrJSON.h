#import <Foundation/Foundation.h>
#import "Attendee.h"

@interface InfoGrabrJSON : NSObject

+ (NSMutableArray*) fetchServices;
+ (NSMutableArray*) fetchTopLeads;
+ (NSMutableArray*) fetchCityTotal;
+ (NSMutableArray*) fetchAttendees;
+ (BOOL)pushAttendeeInfo:(NSString *)info;

@end
