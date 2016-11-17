//
//  Calculator.h
//  SampleOperator
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CalculatorDelegate;

@interface Calculator : NSObject

@property (nonatomic,weak) id<CalculatorDelegate> delegate;

@end

@protocol CalculatorDelegate

- (IBAction)plus:(UIButton *)sender;
- (IBAction)minus:(UIButton *)sender;

@end
