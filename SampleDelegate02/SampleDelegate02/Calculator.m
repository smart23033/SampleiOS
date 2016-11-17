//
//  Calculator.m
//  SampleDelegate02
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize delegate;

-(void)addFirst:(int)first Second:(int)second{

    result = first + second;
    
    [delegate printResult:result];
    
}

-(void)subtractFirst:(int)first Second:(int)second{
    
    result = first - second;
    
    [delegate printResult:result];
    
}

@end
