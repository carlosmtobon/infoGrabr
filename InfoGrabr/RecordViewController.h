

#import <UIKit/UIKit.h>

#import "AttendeeStore.h"

@interface RecordViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *attendeesList;

@end
