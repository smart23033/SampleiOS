//
//  ViewController.h
//  SampleViewDelivery01
//
//  Created by 김성준 on 2016. 10. 17..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *paramEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdate;
@property (weak, nonatomic) IBOutlet UISwitch *paramUpdate;

@property (weak, nonatomic) IBOutlet UILabel *lblInterval;
@property (weak, nonatomic) IBOutlet UIStepper *paramInterval;

- (IBAction)onSwitch:(UISwitch *)sender;
- (IBAction)onStepper:(UIStepper *)sender;
//- (IBAction)onSubmit:(UIBarButtonItem *)sender;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)onPerformSegue:(UIBarButtonItem *)sender;

-(IBAction)unwindToMainViewController:(UIStoryboardSegue *)segue;

@end

