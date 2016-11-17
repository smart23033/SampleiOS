//
//  ViewController.h
//  SampleGPlace
//
//  Created by 김성준 on 2016. 10. 26..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)pickPlace:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

