

#import <UIKit/UIKit.h>

#import <ZXingWidgetController.h>

@interface ScanViewController : UIViewController <ZXingDelegate>

- (IBAction)scanPressed:(id)sender;

@end
