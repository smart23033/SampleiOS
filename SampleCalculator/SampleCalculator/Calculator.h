//
//  Calculator.h
//  SampleCalculator
//
//  Created by 개발자 on 2016. 10. 12..
//  Copyright © 2016년 개발자. All rights reserved.
//

@interface Calculator : NSObject

@property int operand1;
@property int operand2;
@property int accumulator;

-(void)clear;
-(int)performOperation:(char)op;

@end