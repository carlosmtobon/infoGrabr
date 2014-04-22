
#import "RecordViewController.h"
#import "InfoGrabrAppDelegate.h"
#import "InfoGrabrJSON.h"
#import "RecordDetailedViewController.h"

@implementation RecordViewController
@synthesize attendeesList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Records", @"Records");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    attendeesList = [[NSMutableArray alloc] init];
    
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
            add.address = [dic valueForKey:@"address"];
            add.city = [dic valueForKey:@"city"];
            add.country = [dic valueForKey:@"country"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailedViewController *rdvc = [[RecordDetailedViewController alloc ] init];
    Attendee* selAttendee = [attendeesList objectAtIndex: [indexPath row]];
    
    rdvc.attendeeInfo = selAttendee;
    [self.navigationController pushViewController:rdvc animated:YES];
}
@end

