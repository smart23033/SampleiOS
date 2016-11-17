//
//  ViewController.h
//  SampleCalculator
//
//  Created by 개발자 on 2016. 10. 12..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

-(void)processDigit:(int)digit;
-(void)processOp:(char)theOp;

-(IBAction)clickDigit:(UIButton *)sender;

-(IBAction)clickPlus;
-(IBAction)clickMinus;
-(IBAction)clickMultiply;
-(IBAction)clickDivide;

-(IBAction)clickEquals;
-(IBAction)clickClear;


@end

