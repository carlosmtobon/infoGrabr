//
//  RecordReportViewerViewController.m
//  InfoGrabr
//
//  Created by enio pena navarro on 4/23/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "RecordReportViewerViewController.h"

@interface RecordReportViewerViewController ()

@end

@implementation RecordReportViewerViewController
@synthesize reportData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        reportData = [[NSMutableArray alloc] init];
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
    return [reportData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delegate method.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString* a = [reportData objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:a];
    return cell;
}

@end
