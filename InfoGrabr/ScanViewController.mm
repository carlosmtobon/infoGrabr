
#import <MultiFormatReader.h>

#import "InfoGrabrAppDelegate.h"
#import "AttendeeStore.h"
#import "ScanViewController.h"
#import "QuestionnaireViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Scan", @"Scan");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        /*AttendeeStore* store = [(InfoGrabrAppDelegate*)[[UIApplication sharedApplication]delegate] attendeeStore];
        Conference* c1 = [store createConference];
        Conference* c2 = [store createConference];
        c1.confName = @"Conference 1";
        c2.confName = @"Conference 2";
        Attendee* a1 = [store createAttendeeForConf:c1];
        Attendee* a2 = [store createAttendeeForConf:c2];
        a1.firstName = @"Carlos";
        a2.firstName = @"Natalya";
        [store save];*/
        
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

- (IBAction)scanPressed:(id)sender {
    
    ZXingWidgetController* zxingWidgetController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    zxingWidgetController.readers = [[NSSet alloc] initWithObjects:[[MultiFormatReader alloc] init], nil];
    NSBundle* mainBundle = [NSBundle mainBundle];
    zxingWidgetController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:zxingWidgetController animated:YES completion:nil];
   
}

-(void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    NSLog(@"%@", result);
    [self dismissViewControllerAnimated:YES completion:nil];
    InfoGrabrAppDelegate* appdelegate = (InfoGrabrAppDelegate*)[[UIApplication sharedApplication] delegate];
    AttendeeStore* store = appdelegate.attendeeStore;
    NSArray* tokens = [result componentsSeparatedByString:@"$"];
    Attendee* attendee = [store createAttendee];
    attendee.confId = tokens[0];
    attendee.firstName = tokens[1];
    attendee.lastName = tokens[2];
    attendee.organization = tokens[3];
    
    QuestionnaireViewController* qvc = [self.tabBarController.viewControllers objectAtIndex:1];
    
    // TODO set qvc attendee to attendee
    qvc.clientLead = attendee;
    self.tabBarController.selectedViewController = qvc;
}

- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
