//
//  SecondViewController.m
//  SampleSceneTransition
//
//  Created by 개발자 on 2016. 10. 13..
//  Copyright © 2016년 개발자. All rights reserved.
//


#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)pop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
