//
//  MainViewController.h
//  SampleManualSegue
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MainViewController : UIViewController

-(IBAction)wind:(UIButton *)sender;

-(IBAction)unwindToMainViewController:(UIStoryboardSegue *)segue;

@end
