#import <Foundation/Foundation.h>
#import "InfoGrabrJSON.h"

#define SERVICES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=services"
#define CONFERENCES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=conferences"
#define UPLOAD_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=services"

@implementation InfoGrabrJSON

+ (void)fetchURL: (NSString*)urlStr handler:(void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    // request data from web service
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:handler];
}

+ (NSData *)fetchURLSync: (NSString*)urlStr //handler://NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    // request data from web service
    //NSURL *url = [[NSURL alloc] initWithString:urlStr];
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        // Parse data here
    }
    
    return data;
}

+ (void)fetchServices: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    [InfoGrabrJSON fetchURL:SERVICES_URL handler:handler];
}

+ (NSData *)fetchServicesSync//: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    return [InfoGrabrJSON fetchURLSync:SERVICES_URL];
    
}

+ (void)fetchConferences: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    [InfoGrabrJSON fetchURL:CONFERENCES_URL handler:handler];
}


@end
