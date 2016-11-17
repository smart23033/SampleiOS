//
//  ViewController.h
//  SampleSceneTransition
//
//  Created by 개발자 on 2016. 10. 13..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *uiTItle;

- (IBAction)moveNext:(UIButton *)sender;
- (IBAction)moveByNavi:(UIBarButtonItem *)sender;

@end

