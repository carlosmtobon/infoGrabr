#import <Foundation/Foundation.h>
#import "Attendee.h"

@interface InfoGrabrJSON : NSObject

+ (NSMutableArray*) fetchServices;
+ (NSMutableArray*) fetchConferences;

+ (NSMutableArray*) fetchTopLeads;
+ (NSMutableArray*) fetchCityTotal;
+ (NSMutableArray*) fetchStateTotal;
+ (NSMutableArray*) fetchCountryTotal;
+ (NSMutableArray*) fetchCompanyTotal;
+ (NSMutableArray*) fetchOrganizationTotal;
+ (NSMutableArray*) fetchTimeFrameTotal;

+ (NSMutableArray*) fetchAttendees;
+ (BOOL)pushAttendeeInfo:(NSString *)info;

@end
