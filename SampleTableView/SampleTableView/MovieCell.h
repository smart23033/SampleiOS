//
//  MovieCell.h
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 19..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblOpenDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UIImageView *ivThumbnail;

@end
