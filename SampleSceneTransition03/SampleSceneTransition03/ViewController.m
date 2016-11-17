//
//  ViewController.m
//  SampleSceneTransition03
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"segueForPage2"]){
        NSLog(@"Show 타입의 세그");
    }else if([segue.identifier isEqual:@"customSegueForPage2"]){
        NSLog(@"Custom 타입의 세그");
    }else{
        NSLog(@"알수없는 타입의 세그");
    }
}

-(IBAction)unwindToPage1:(UIStoryboardSegue *)segue{
    
}

@end
