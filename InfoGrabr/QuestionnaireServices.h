//
//  QuestionnaireServices.h
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/17/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionnaireServices : NSObject

@property (strong,nonatomic) NSMutableArray *services;

@property (strong,retain) NSString *response;

-(void)servicesFromURL;

@end
