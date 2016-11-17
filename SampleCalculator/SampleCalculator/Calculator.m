//
//  Calculator.m
//  SampleCalculator
//
//  Created by 개발자 on 2016. 10. 12..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

@implementation Calculator

@synthesize operand1,operand2,accumulator;

-(id) init
{
    self = [super init];
    
    if(self){
        operand1 = [self operand1];
        operand2 = [self operand2];
    }
 
    
    NSLog(@"operand1 = %i, operand2 = %i",[self operand1],[self operand2]);
    
    return self;
}

-(void)clear
{
    accumulator = 0;
}

-(int)performOperation:(char)op
{
    
    NSLog(@"operand1 = %i, operand2 = %i",[self operand1],[self operand2]);
    
    switch (op) {
        case '+':
            accumulator = [self operand1] + [self operand2];
            break;
        case '-':
            accumulator = [self operand1] - [self operand2];
            break;
        case '*':
            accumulator = [self operand1] * [self operand2];
            break;
        case '/':
            accumulator = [self operand1] / [self operand2];
            break;
        default:
            break;
            
    }
    
    NSLog(@"accumulator = %i",accumulator);
    
    return accumulator;
    
}

@end
