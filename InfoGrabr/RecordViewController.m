
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
    
    
    // fetch from web service (synchronously)
    NSData* data = [InfoGrabrJSON fetchAttendeesSync];
    NSError *error = nil;
    
    if (data)
    {
        // build array of service names from requested data
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [attendeesList removeAllObjects];
        AttendeeStore* store = [(InfoGrabrAppDelegate*)[[UIApplication sharedApplication]delegate] attendeeStore];
        for (NSDictionary* dic in json)
        {
            
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
            
            [attendeesList addObject:add];
        }
        
        
        NSLog(@"attendeesList: %@", attendeesList);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [attendeesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delegate method.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    Attendee* a = [attendeesList objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:a.firstName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailedViewController *rdvc = [[RecordDetailedViewController alloc ] init];
    Attendee* selAttendee = [attendeesList objectAtIndex: [indexPath row]];
    
    rdvc.attendeeInfo = selAttendee;
    [self.navigationController pushViewController:rdvc animated:YES];
}


- (IBAction)viewReports:(id)sender
{
    RecordReportViewController *rrvc = [[RecordReportViewController alloc] init];
    [[self navigationController] pushViewController:rrvc animated:YES];
}

@end

