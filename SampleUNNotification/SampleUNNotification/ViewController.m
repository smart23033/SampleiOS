//
//  ViewController.m
//  SampleUNNotification
//
//  Created by 김성준 on 2016. 11. 9..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didSelectDate:(UIDatePicker *)sender {
    NSLog(@"date : %@",sender.date);
    
    NSDate *selectedDate = sender.date;
    
    id delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate scheduleNotification:selectedDate];
}
@end
