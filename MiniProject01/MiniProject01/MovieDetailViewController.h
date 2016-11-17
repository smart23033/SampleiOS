//
//  MovieDetailViewController.h
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 16..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MovieVO.h"

@interface MovieDetailViewController : UIViewController

@property (nonatomic,strong) MovieVO *mvo;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavigationItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleEnLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *audiAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;

- (void)callMovieDetailAPI;

@end
