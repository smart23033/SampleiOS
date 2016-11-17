//
//  ViewController.m
//  SampleDelegate02
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    calculator = [Calculator new];
    calculator.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchUpPlus:(UIButton *)sender {
    
    first = [self.firstOperand.text intValue];
    second = [self.secondOperand.text intValue];
    
    [calculator addFirst:first Second:second];
    
}

- (IBAction)touchUpMinus:(UIButton *)sender {
    
    first = [self.firstOperand.text intValue];
    second = [self.secondOperand.text intValue];
    
    [calculator subtractFirst:first Second:second];
    
}

-(void)printResult:(int)result{
    self.resultLabel.text = [NSString stringWithFormat:@"%d",result];
    
    self.firstOperand.text = @"";
    self.secondOperand.text = @"";
}

@end
