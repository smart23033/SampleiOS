//
//  ViewController.m
//  SampleViewDelivery01
//
//  Created by 김성준 on 2016. 10. 17..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize lblUpdate,lblInterval;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onStepper:(UIStepper *)sender {
    int value = [sender value];
    
    lblInterval.text = [NSString stringWithFormat:@"%d분마다 ",value];
    
}



- (IBAction)onSwitch:(UISwitch *)sender {
    
    if([sender isOn]){
        lblUpdate.text = @"갱신함";
    }else{
        lblUpdate.text = @"갱신하지 않음";
    }

}

//- (IBAction)onSubmit:(UIBarButtonItem *)sender {
//
//    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
//    ResultViewController *rvc = [ResultViewController new];
//    
//    if([vc isKindOfClass:[ResultViewController class]]){
//        
//        rvc = (ResultViewController *)vc;
//        
//        rvc->paramEmail = self.paramEmail.text;
//        rvc->paramUpdate = self.paramUpdate.on;
//        rvc->paramInterval = self.paramInterval.value;
//        
//        
////        [self presentViewController:rvc animated:true completion:nil];
//        [self.navigationController pushViewController:rvc animated:true];
//    }
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = [segue destinationViewController];
    ResultViewController *rvc = [ResultViewController new];
    
    if([vc isKindOfClass:[ResultViewController class]]){
        
        rvc = (ResultViewController *)vc;
        
        rvc->paramEmail = self.paramEmail.text;
        rvc->paramUpdate = self.paramUpdate.on;
        rvc->paramInterval = self.paramInterval.value;
    }
}

- (IBAction)onPerformSegue:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"ManualSubmit" sender:self];
    
}

-(IBAction)unwindToMainViewController:(UIStoryboardSegue *)segue{
    
}

@end
