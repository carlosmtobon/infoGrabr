//
//  AttendeeStore.m
//  InfoGrabr
//
//  Created by Carlos Tobon on 4/13/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "AttendeeStore.h"


@implementation AttendeeStore

@synthesize allAttendees;
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

/*
 * function that loads all attendees into an NSArray using coredata
 */
- (void)loadAllAttendees {
    if (!allAttendees) {
        
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        NSEntityDescription* e = [[model entitiesByName] objectForKey:@"Attendee"];
        request.entity = e;
        
        NSError* error = nil;
        NSArray* result = [ctx executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        allAttendees = [[NSMutableArray alloc] initWithArray:result];
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
        [self loadAllAttendees];
    }
    return self;
}

/*
 * Saves all attendees to local storage using coredata
 */
-(BOOL) save {
    
    NSError* error = nil;
    BOOL successful = [self.ctx save:&error];
    if (!successful) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return successful;
}

/*
 * Create a Attendee Managed Object
 */
-(Attendee*) createAttendee{
    Attendee* attendee = [NSEntityDescription insertNewObjectForEntityForName:@"Attendee" inManagedObjectContext:ctx];;
    return attendee;
}


/*
 * Deletes an attendee from local Storage
 */
- (void)removeAttendee:(Attendee *)attendee {
    [ctx deleteObject:attendee];
}


/*
 * This wipes the local db by deleting the store file
 */
-(void) removeDatabase {
    if([[NSFileManager defaultManager] fileExistsAtPath:self.getStorePath]){
        [[NSFileManager defaultManager] removeItemAtPath:self.getStorePath error:nil];
    }
}
@end
