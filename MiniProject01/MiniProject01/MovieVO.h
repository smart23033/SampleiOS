//
//  MovieVO.h
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 15..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieVO : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleEn;
@property (nonatomic, strong) NSString *audiAcc;
@property (nonatomic, strong) NSString *openDate;
@property (nonatomic, strong) NSString *watchGrade;
@property (nonatomic, strong) NSMutableArray<NSString *> *genres;
@property (nonatomic, strong) NSMutableArray<NSString *> *directors;
@property (nonatomic, strong) NSMutableArray<NSString *> *actors;

@end
