//
//  ViewController.h
//  SampleDelegate02
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface ViewController : UIViewController<CalculatorDelegate>{
    Calculator *calculator;
    int first;
    int second;
}

@property (weak, nonatomic) IBOutlet UITextField *firstOperand;
@property (weak, nonatomic) IBOutlet UITextField *secondOperand;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)touchUpPlus:(UIButton *)sender;
- (IBAction)touchUpMinus:(UIButton *)sender;

@end

