//
//  SearchViewController.m
//  SampleAFNetworking
//
//  Created by 김성준 on 2016. 11. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"
#import "SWRevealViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    _locationTextField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = [segue destinationViewController];
    ResultViewController *rvc = [ResultViewController new];
    
    if([vc isKindOfClass:[ResultViewController class]]){
        
        rvc = (ResultViewController *)vc;
        rvc.locationLabel.title = _locationTextField.text.capitalizedString;
        
        
        NSLog(@"location TextField : %@",_locationTextField.text);
    }
}

@end
