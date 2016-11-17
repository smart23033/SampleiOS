//
//  MovieVO.h
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 19..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieVO : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *opendate;
@property (nonatomic) float rating;
@property (nonatomic, strong) NSString *thumbnail;

//이놈 추가
@property (nonatomic, strong) UIImage *thumbnailImage;

@end
