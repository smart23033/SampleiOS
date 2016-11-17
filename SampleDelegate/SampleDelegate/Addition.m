//
//  Addition.m
//  SampleDelegate
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "Addition.h"

@implementation Addition

@synthesize delegate,first,second;

-(void)passTwoNumber:(int)one withAnother:(int)two{
    first = one;
    second = two;
}

-(void)computeAddition{
    int addition = first + second;
    
    [delegate printAddition:addition];
}

@end
