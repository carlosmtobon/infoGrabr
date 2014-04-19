//
//  AttendeeStore.m
//  InfoGrabr
//
//  Created by Carlos Tobon on 4/13/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "AttendeeStore.h"


@implementation AttendeeStore

@synthesize allConferences;
@synthesize ctx;
@synthesize model;

// get the path of where sqllite db is stored
-(NSString*) getStorePath {
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    // Get one and only document directory from thatlist
    NSString *documentDirectory =
    [documentDirectories objectAtIndex:0];
    return [documentDirectory
            stringByAppendingPathComponent:@"store.data"];
}

- (void)loadAllConferences {
    if (!allConferences) {
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        NSEntityDescription* e = [[model entitiesByName] objectForKey:@"Conference"];
        request.entity = e;
        
        NSError* error = nil;
        NSArray* result = [ctx executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        allConferences = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        NSString* path = [self getStorePath];
        NSURL* storeUrl = [NSURL fileURLWithPath:path];
        NSError* error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        ctx = [[NSManagedObjectContext alloc] init];
        [ctx setPersistentStoreCoordinator:psc];
        [ctx setUndoManager:nil];
        [self loadAllConferences];
    }
    return self;
}

-(BOOL) save {
    
    NSError* error = nil;
    BOOL successful = [self.ctx save:&error];
    if (!successful) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return successful;
}

-(Attendee*) createAttendeeForConf:(Conference *)conf {
    Attendee* attendee = [NSEntityDescription insertNewObjectForEntityForName:@"Attendee" inManagedObjectContext:ctx];
    [conf addAttendeesObject:attendee];
    return attendee;
}

-(Conference *)createConference {
    Conference* conf = [NSEntityDescription insertNewObjectForEntityForName:@"Conference" inManagedObjectContext:ctx];
    [allConferences addObject:conf];
    return conf;
}

- (void)removeAttendee:(Attendee *)attendee FromConf:(Conference *)conf {
    [ctx deleteObject:attendee];
    NSMutableSet *mutableSet = [NSMutableSet setWithSet:conf.attendees];
    [mutableSet removeObject:attendee];
    conf.attendees = mutableSet;
}

- (void)removeConference:(Conference *)conf {
    [ctx deleteObject:conf];
    [allConferences removeObject:conf];
}

@end
