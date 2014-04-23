

#import "InfoGrabrAppDelegate.h"

#import "ScanViewController.h"

#import "QuestionnaireViewController.h"

#import "RecordViewController.h"

@implementation InfoGrabrAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.attendeeStore = [[AttendeeStore alloc] init];
    
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[ScanViewController alloc] initWithNibName:@"ScanViewController" bundle:nil];
    UIViewController *viewController2 = [[QuestionnaireViewController alloc] initWithNibName:@"QuestionnaireViewController" bundle:nil];
    UIViewController *viewController3 = [[RecordViewController alloc] init];
    
    
    UINavigationController *viewController4 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController4];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
