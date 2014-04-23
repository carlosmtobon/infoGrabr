
#import <UIKit/UIKit.h>

@interface RecordViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *searchResults;
    
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@property (strong, nonatomic) NSMutableArray *attendeesList;

@end
