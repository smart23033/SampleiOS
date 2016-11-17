//
//  ViewController.m
//  SampleIB
//
//  Created by 개발자 on 2016. 10. 13..
//  Copyright © 2016년 개발자. All rights reserved.
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


- (IBAction)touchUpBtn:(UIButton *)sender {
    self.uiTitle.text = @"touch up btn";
}

@end
