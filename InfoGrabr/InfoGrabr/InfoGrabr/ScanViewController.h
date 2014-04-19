

#import <UIKit/UIKit.h>

#import <ZXingWidgetController.h>

#import "AttendeeStore.h"

@interface ScanViewController : UIViewController <ZXingDelegate>

- (IBAction)scanPressed:(id)sender;

@end
