//
//  Addition.h
//  SampleDelegate
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdditionDelegate <NSObject>

-(void)printAddition:(int)result;

@end

@interface Addition : NSObject{
    int first, second;
}

@property (nonatomic, weak) id<AdditionDelegate> delegate;
@property int first, second;

-(void)passTwoNumber:(int)one withAnother:(int)two;
-(void)computeAddition;

@end
