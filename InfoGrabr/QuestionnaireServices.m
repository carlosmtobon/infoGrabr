//
//  QuestionnaireServices.m
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/17/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "QuestionnaireServices.h"

@implementation QuestionnaireServices

@synthesize services;

-(id)init
{
    self = [super init];
    
    if (self) {
        
        services = [[NSMutableArray alloc] initWithObjects:@"Analysis Consult", @"Biorepository", @"Gene Expression", @"Genotyping", @"Sequencing", nil];
    }
    
    return self;
}

-(void)servicesFromURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://someurl/misc/somthing.php"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        
    } else {
        //if connection fails
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    _response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    connection = nil;
}

@end
