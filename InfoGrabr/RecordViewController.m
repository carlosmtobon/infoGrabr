
#import "RecordViewController.h"
#import "InfoGrabrAppDelegate.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

@synthesize attendeeStore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Records", @"Records");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        attendeeStore = [(InfoGrabrAppDelegate*)[[UIApplication sharedApplication] delegate] attendeeStore];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    return [[attendeeStore allAttendees] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delegate method.
    UITableViewCell *cell =
    [[UITableViewCell alloc]
     initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:@"UITableViewCell"];
    Attendee* a = [[attendeeStore allAttendees]
                  objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:a.firstName];
    return cell;
}
@end

