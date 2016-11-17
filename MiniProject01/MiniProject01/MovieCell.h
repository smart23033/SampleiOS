//
//  MovieCellTableViewCell.h
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 15..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *openDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *audiAccLabel;

@end
