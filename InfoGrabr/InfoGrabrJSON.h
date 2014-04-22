#import <Foundation/Foundation.h>

@interface InfoGrabrJSON : NSObject

+ (void)fetchServices: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler;
+ (void)fetchConferences: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler;

+ (NSData *)fetchServicesSync;

@end
