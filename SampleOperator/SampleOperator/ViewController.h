//
//  ViewController.h
//  SampleOperator
//
//  Created by 개발자 on 2016. 10. 13..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface ViewController : UIViewController<CalculatorDelegate>{
    Calculator *calculator;
}

@property (weak, nonatomic) IBOutlet UITextField *firstOperand;
@property (weak, nonatomic) IBOutlet UITextField *secondOperand;
@property (weak, nonatomic) IBOutlet UILabel *result;

@end
