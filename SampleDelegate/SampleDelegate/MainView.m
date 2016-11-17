//
//  MainView.m
//  SampleDelegate
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//
#import "MainView.h"

@implementation MainView

-(void)startDelegate:(int)one withTwo:(int)two{
    addition = [Addition new];
    addition.delegate = self;
    [addition passTwoNumber:one withAnother:two];
}

-(void)executeDelegate{
    [addition computeAddition];
}

-(void)printAddition:(int)result{
    NSLog(@"result : %d",result);
}
@end
