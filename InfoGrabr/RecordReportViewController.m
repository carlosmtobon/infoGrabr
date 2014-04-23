//
//  RecordReportViewController.m
//  InfoGrabr
//
//  Created by enio pena navarro on 4/22/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "RecordReportViewController.h"

@interface RecordReportViewController ()

@end

@implementation RecordReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        reportTypeList = [[NSArray alloc] initWithObjects:  @"Top Leads (Likert)",
                                                            @"Totals by City",
                                                            @"Totals by State",
                                                            @"Totals by Country",
                                                            @"Totals by Company",
                                                            @"Totals by Organization",
                                                            @"Totals by Time Frame", nil];
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [reportTypeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delegate method.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString* a = [reportTypeList objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:a];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RecordDetailedViewController *rdvc = [[RecordDetailedViewController alloc ] init];
//    Attendee* selAttendee = [attendeesList objectAtIndex: [indexPath row]];
//    
//    rdvc.attendeeInfo = selAttendee;
//    [self.navigationController pushViewController:rdvc animated:YES];
}

@end
