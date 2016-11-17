

#import <UIKit/UIKit.h>
#import "TheaterCell.h"
#import "TheaterViewController.h"

@interface TheaterListController : UITableViewController{
    int startPoint;
}

@property (nonatomic) NSMutableArray<NSDictionary *> *list;
@property (weak, nonatomic) IBOutlet UITableView *theaterTable;

- (void) callTheaterAPI;


@end
