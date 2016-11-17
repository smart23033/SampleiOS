//
//  ViewController.m
//  SampleCalculator
//
//  Created by 개발자 on 2016. 10. 12..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char op;
    BOOL firstOperand;
    Calculator *myCalculator;
    NSMutableString *displayString;
}

@synthesize display;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    firstOperand = YES;
    displayString = [NSMutableString stringWithCapacity:40];
    myCalculator = [[Calculator alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)processDigit:(int)digit
{
    
    [displayString appendString:[NSString stringWithFormat:@"%i", digit]];
    
    display.text = displayString;
    
    NSLog(@"digit = %i",digit);
}

-(IBAction)clickDigit:(UIButton *)sender
{
    int digit = sender.tag;
    
    [self processDigit:digit];
    
}

-(void)processOp:(char)theOp
{
    NSString *opStr;
    
    op = theOp;
    
    switch (theOp) {
        case '+':
            opStr = @" + ";
            break;
        case '-':
            opStr = @" - ";
            break;
        case '*':
            opStr = @" * ";
            break;
        case '/':
            opStr = @" / ";
            break;
    }
    
    firstOperand = NO;
    
    [displayString appendString:opStr];
    display.text = displayString;
    
     NSLog(@"operator = %@",opStr);
}

-(void)clickPlus
{
    [self processOp:'+'];
}

-(void)clickMinus
{
    [self processOp:'-'];
}
-(void)clickMultiply
{
    [self processOp:'*'];
}
-(void)clickDivide
{
    [self processOp:'/'];
}

-(void)clickClear
{
    firstOperand = YES;
    [myCalculator clear];
    [displayString setString:@""];
    display.text = displayString;
}
-(void)clickEquals
{
    if(firstOperand == NO){
        [myCalculator performOperation: op];
        
        [displayString appendString:@" = "];
        [displayString appendFormat:@"%i",myCalculator.accumulator];
        display.text = displayString;
        
        firstOperand = YES;
        [displayString setString:@""];
    }
}

@end
