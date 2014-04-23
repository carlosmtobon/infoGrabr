//
//  RecordReportViewController.m
//  InfoGrabr
//
//  Created by enio pena navarro on 4/22/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "RecordReportViewController.h"
#import "RecordReportViewerViewController.h"
#import "InfoGrabrJSON.h"

typedef enum {
    TOP_LEADS,
    CITY_TOTAL,
    STATE_TOTAL,
    COUNTRY_TOTAL,
    COMPANY_TOTAL,
    ORG_TOTAL,
    TIMEFRAME_TOTAL
} ReportType ;

@implementation RecordReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.title = NSLocalizedString(@"Reports", @"Reports");
        
        // Custom initialization
        reportTypeList = [[NSArray alloc] initWithObjects:  @"Top Leads (Likert)",
                                                            @"Total by City",
                                                            @"Total by State",
                                                            @"Total by Country",
                                                            @"Total by Company",
                                                            @"Total by Organization",
                                                            @"Total by Time Frame", nil];
        
//        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [titleButton setTitle:@"Title" forState:UIControlStateNormal];
//        [titleButton setFrame:CGRectMake(0, 0, 200, 35)];
//        self.navigationItem.titleView = titleButton;
        
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
    RecordReportViewerViewController *rrvvc = [[RecordReportViewerViewController alloc ] init];
    
    NSString* selectedReport = [reportTypeList objectAtIndex:[indexPath row]];
    rrvvc.title = selectedReport;
    [rrvvc.reportData removeAllObjects];
    
    // determine which report type has been selected
    // and fetch data from web service as needed
    switch ((ReportType)[indexPath row])
    {
        case TOP_LEADS:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchTopLeads];
            break;
        }
        case CITY_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchCityTotal];
            break;
        }
        case COUNTRY_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchCountryTotal];
            break;
        }
        case STATE_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchStateTotal];
            break;
        }
        case COMPANY_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchCompanyTotal];
            break;
        }
        case ORG_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchOrganizationTotal];
            break;
        }
        case TIMEFRAME_TOTAL:
        {
            rrvvc.reportData = [InfoGrabrJSON fetchTimeFrameTotal];
            break;
        }
        default:
            break;
    }
    
    // fetch report data and populate
    [self.navigationController pushViewController:rrvvc animated:YES];
}

@end
