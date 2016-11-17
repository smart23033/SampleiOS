//
//  ViewController.m
//  SampleSceneTransition
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

- (IBAction)moveNext:(UIButton *)sender {
    
    UIViewController *uvc = [UIViewController new];
    
    //    uvc = self.storyboard.instantiateInitialViewController;
    
    uvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    
    [self presentViewController:uvc animated:YES completion:nil];
    
}

- (IBAction)moveByNavi:(UIBarButtonItem *)sender {
    
    UIViewController *uvc = [UIViewController new];
    
    uvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    
    [self.navigationController pushViewController:uvc animated:true];
    
    
}
@end
