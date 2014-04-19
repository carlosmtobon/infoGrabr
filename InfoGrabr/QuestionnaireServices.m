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

@end
