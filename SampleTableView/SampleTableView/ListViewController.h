//
//  ViewController.h
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 18..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCell.h"
#import "DetailViewController.h"

@class MovieVO;

@interface ListViewController : UITableViewController{
    MovieVO *mvo;
    int page;
}

@property (nonatomic) NSMutableArray<MovieVO *> *list;
@property (strong, nonatomic) IBOutlet UITableView *movieTable;
 
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

- (IBAction)touchUpMore:(id)sender;

- (void)callMovieAPI;

- (UIImage *) getThumbnailImage:(int) index;

@end
