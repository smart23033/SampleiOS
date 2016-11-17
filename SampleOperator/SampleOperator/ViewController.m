//
//  ViewController.m
//  SampleOperator
//
//  Created by 개발자 on 2016. 10. 13..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize firstOperand, secondOperand, result;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    calculator.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)plus:(UIButton *)sender {
    int first = [self.firstOperand.text intValue];
    int second = [self.secondOperand.text intValue];
    NSString *resultString = [NSString stringWithFormat:@"%d",first + second];
    
    self.result.text = resultString;
    self.firstOperand.text = @"";
    self.secondOperand.text = @"";
    
}

- (IBAction)minus:(UIButton *)sender {
    int first = [self.firstOperand.text intValue];
    int second = [self.secondOperand.text intValue];
    NSString *resultString = [NSString stringWithFormat:@"%d",first - second];
    
    self.result.text = resultString;
    self.firstOperand.text = @"";
    self.secondOperand.text = @"";
}

@end
