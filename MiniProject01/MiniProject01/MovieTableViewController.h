//
//  MovieTableViewController.h
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 15..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>


@interface MovieTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UITableView *movieTable;

- (void)callMovieAPI;
@end
