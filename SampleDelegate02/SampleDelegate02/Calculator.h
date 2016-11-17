//
//  Calculator.h
//  SampleDelegate02
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalculatorDelegate <NSObject>

-(void)printResult:(int)result;

@end

@interface Calculator : NSObject{
    int result;
}

@property (nonatomic, weak) id<CalculatorDelegate> delegate;

-(void)addFirst:(int)first Second:(int)second;
-(void)subtractFirst:(int)first Second:(int)second;

@end

