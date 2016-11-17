//
//  ResultViewController.m
//  SampleViewDelivery01
//
//  Created by 김성준 on 2016. 10. 17..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.resultEmail.text = paramEmail;
    self.resultUpdate.text = (paramUpdate == true) ? @"자동갱신" : @"자동갱신 안함";
    self.resultInterval.text = [NSString stringWithFormat:@"%d분마다 갱신",paramInterval];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}
@end
