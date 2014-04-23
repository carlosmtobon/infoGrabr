
#import "RecordViewController.h"
#import "InfoGrabrAppDelegate.h"
#import "InfoGrabrJSON.h"
#import "RecordDetailedViewController.h"
#import "RecordReportViewController.h"

@implementation RecordViewController
@synthesize attendeesList;

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Records", @"Records");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        // set navigation bar buttons
        // Create a new bar button item that will send
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCompose target:self action:@selector(viewReports:)];
        
        // Set this bar button item as the right item in the navigationItem
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        // itialize data
        attendeesList = [[NSMutableArray alloc] init];
        
        searchResults = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    
    // fetch from attendees web service (synchronously)
    attendeesList = [InfoGrabrJSON fetchAttendees];
    
    /*the search bar width must be > 1, the height must be at least 44
     (the real size of the search bar)*/
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    /*contents controller is the UITableViewController, this let you to reuse
     the same TableViewController Delegate method used for the main table.*/
    
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    // for search results table view to use delegates like didSelectRowAtIndexPath
    searchDisplayController.searchResultsDelegate = self;
    
    self.tableView.tableHeaderView = searchBar; //this line add the searchBar
    //on the top of tableView.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [attendeesList count];   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delegate method.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Attendee* a = nil;
    // if it is the table view in which the search results are displayed
    // then use seacrhResults Array
    if (tableView == self.searchDisplayController.searchResultsTableView)
        a = [searchResults objectAtIndex:[indexPath row]];
    else
        a = [attendeesList objectAtIndex:[indexPath row]];

    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@: %@ %@",a.confId,a.firstName,a.lastName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailedViewController *rdvc = [[RecordDetailedViewController alloc ] init];
    Attendee* selAttendee = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
        selAttendee = [searchResults objectAtIndex: [indexPath row]];
    else
        selAttendee = [attendeesList objectAtIndex: [indexPath row]];
    
    rdvc.attendeeInfo = selAttendee;
    [self.navigationController pushViewController:rdvc animated:YES];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [searchResults removeAllObjects];
    //remove all elements from the array that will contain found items
    
    Attendee *a;
    
    // Search and recreate structure of the original array 
    
    for(a in attendeesList)
    {

        NSString *element = [NSString stringWithFormat:@"%@: %@ %@",a.confId,a.firstName,a.lastName];
        
        // get string index location and length
        NSRange range = [element rangeOfString:searchString
                                       options:NSCaseInsensitiveSearch];
        
        if (range.length > 0) { //if the substring match
            [searchResults addObject:a];//add the element to group
        }

    }
    
    return YES;
}


- (IBAction)viewReports:(id)sender
{
    RecordReportViewController *rrvc = [[RecordReportViewController alloc] init];
    [[self navigationController] pushViewController:rrvc animated:YES];
}

@end