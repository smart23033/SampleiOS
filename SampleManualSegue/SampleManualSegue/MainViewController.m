//
//  MainViewController.m
//  SampleManualSegue
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

-(IBAction)wind:(UIButton *)sender{
    [self performSegueWithIdentifier:@"ManualWind" sender:self];
}

-(IBAction)unwindToMainViewController:(UIStoryboardSegue *)segue{
    
}
@end
