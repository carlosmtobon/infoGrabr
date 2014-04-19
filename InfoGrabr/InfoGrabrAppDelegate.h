

#import <UIKit/UIKit.h>

#import "AttendeeStore.h"

@interface InfoGrabrAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) AttendeeStore* attendeeStore;

@end
