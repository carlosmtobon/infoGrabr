#import <Foundation/Foundation.h>
#import "InfoGrabrJSON.h"
#import "Attendee.h"

#define SERVICES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=services"
#define CONFERENCES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=conferences"
#define ATTENDEES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=attendees"
#define PUSH_ATTENDEES_URL @"http://www.eniopn.com/infograbr/create.php"

@implementation InfoGrabrJSON

+ (void)fetchURL: (NSString*)urlStr handler:(void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    // request data from web service
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:handler];
}

+ (NSData *)postDataToUrl:(NSString*)urlString :(NSString*)jsonString
{
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonString];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse* response;
    NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"the final output is:%@",responseString);
    
    return responseData;
}

+ (BOOL) postDataToUrlSync: (NSString*) urlString : (NSString*)data
{
    NSData* pdata = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [postRequest setValue:[NSString stringWithFormat:@"%d", [pdata length]] forHTTPHeaderField:@"Content-Length"];
    [postRequest setHTTPBody:pdata];

    NSURLResponse *response = nil;
    NSError *requestError = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&requestError];

    if (requestError == nil && returnData && returnData.length > 0)
        return YES;
    return NO;
}

+ (NSData *)fetchURLSync: (NSString*)urlStr
{
    // request data from web service
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    return data;
}

+ (void)fetchServices: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    [InfoGrabrJSON fetchURL:SERVICES_URL handler:handler];
}

+ (NSData *)fetchServicesSync
{
    return [InfoGrabrJSON fetchURLSync:SERVICES_URL];
    
}

+ (void)fetchConferences: (void (^)(NSURLResponse *resp, NSData *data, NSError *error)) handler
{
    [InfoGrabrJSON fetchURL:CONFERENCES_URL handler:handler];
}

+ (NSData *)fetchConferencesSync
{
    return [InfoGrabrJSON fetchURLSync:CONFERENCES_URL];
}


+ (NSData *)fetchAttendeesSync
{
    return [InfoGrabrJSON fetchURLSync:ATTENDEES_URL];
}

+ (BOOL)pushAttendeeSync:(NSString *)info
{
    return [InfoGrabrJSON postDataToUrlSync:PUSH_ATTENDEES_URL :info];
}

@end
