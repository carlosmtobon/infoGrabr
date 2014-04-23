#import <Foundation/Foundation.h>
#import "InfoGrabrJSON.h"
#import "Attendee.h"
#import "AttendeeStore.h"
#import "InfoGrabrAppDelegate.h"

#define SERVICES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=services"
#define CONFERENCES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=conferences"
#define ATTENDEES_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=attendees"
#define PUSH_ATTENDEES_URL @"http://www.eniopn.com/infograbr/create.php"
#define TOPLEADS_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=topleads"
#define CITY_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=city"
#define STATE_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=state"
#define COUNTRY_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=country"
#define COMPANY_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=company"
#define ORGANIZATION_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=organization"
#define TIMEFRAME_TOTAL_URL @"http://www.eniopn.com/infograbr/index.php?getinfo=timeframe"

@implementation InfoGrabrJSON

// Helper: make a post request with the specified json string to the specified url
+ (BOOL) jsonDataPostRequestToURL: (NSString*) urlString : (NSString*)data
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

// Helper method: send synchronous request to specified url and return the results
+ (NSData *)sendSynchronousRequestToUrl: (NSString*)urlStr
{
    // request data from web service
    // Send a synchronous request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    return data;
}

+ (NSDictionary*) fetchJSONToDictionary: (NSString*)urlStr
{
    NSData* webServiceResults = [InfoGrabrJSON sendSynchronousRequestToUrl:urlStr];
    NSError *error = nil;
    if (webServiceResults)
    {
        return [NSJSONSerialization JSONObjectWithData:webServiceResults
                                    options:NSJSONReadingMutableContainers
                                    error:&error];
    }
    return nil;
}

+ (NSMutableArray*) fetchServices
{
    // store services info into dictionary
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:SERVICES_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through results dictionary and grab what we need
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[dic valueForKey:@"name"]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchConferences
{
    // store services info into dictionary
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:CONFERENCES_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through results dictionary and grab what we need
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[dic valueForKey:@"name"]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchTopLeads
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:TOPLEADS_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@ %@ %@",
                                                    [dic valueForKey:@"firstName"],
                                                    [dic valueForKey:@"lastName"],
                                                    [dic valueForKey:@"phone1"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchCityTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:CITY_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"city"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchStateTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:STATE_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"state"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchCountryTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:COUNTRY_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"country"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchCompanyTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:COMPANY_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"company"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchOrganizationTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:ORGANIZATION_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"organization"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchTimeFrameTotal
{
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:TIMEFRAME_TOTAL_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // loop through dictionary that was retrieved from the web
        for (NSDictionary* dic in resultsDict)
        {
            [arr addObject:[NSString stringWithFormat:@"%@    (%@)",
                            [dic valueForKey:@"projectTimeframe"],
                            [dic valueForKey:@"total"]]];
        }
        
        return arr;
    }
    return nil;
}

+ (NSMutableArray*) fetchAttendees
{
    // store services info into dictionary
    NSDictionary* resultsDict = [InfoGrabrJSON fetchJSONToDictionary:ATTENDEES_URL];
    if (resultsDict)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        
        // grab global store object
        AttendeeStore* store = [(InfoGrabrAppDelegate*)[[UIApplication sharedApplication]delegate]attendeeStore];
        
        // loop through results dictionary and grab what we need
        for (NSDictionary* dic in resultsDict)
        {
            // parse dictionary into attendee object
            Attendee* add = [store createAttendee];
            add.confName = [dic valueForKey:@"confName"];
            add.confId = [dic valueForKey:@"confId"];
            add.cgtServices = [dic valueForKey:@"cgtServices"];
            add.firstName = [dic valueForKey:@"firstName"];
            add.lastName = [dic valueForKey:@"lastName"];
            add.address = [dic valueForKey:@"address"];
            add.city = [dic valueForKey:@"city"];
            add.country = [dic valueForKey:@"country"];
            add.company = [dic valueForKey:@"company"];
            add.email = [dic valueForKey:@"email"];
            add.extraInfo = [dic valueForKey:@"extraInfo"];
            add.membership = [dic valueForKey:@"membership"];
            add.office = [dic valueForKey:@"office"];
            add.organization = [dic valueForKey:@"organization"];
            add.phone1 = [dic valueForKey:@"phone1"];
            add.phone2 = [dic valueForKey:@"phone2"];
            add.state = [dic valueForKey:@"state"];
            add.zipcode = [dic valueForKey:@"zipcode"];
            add.projectTimeframe = [dic valueForKey:@"projectTimeFrame"];
            add.dateCreated = [dic valueForKey:@"dateCreated"];
            add.lykerNum = [dic valueForKey:@"lykerNum"];
            
            [arr addObject:add];
        }
        
        return arr;
    }
    return nil;
}

+ (BOOL)pushAttendeeInfo:(NSString *)info
{
    return [InfoGrabrJSON jsonDataPostRequestToURL:PUSH_ATTENDEES_URL :info];
}

@end
