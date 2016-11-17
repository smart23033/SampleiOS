//
//  ViewController.h
//  SampleCoreData
//
//  Created by 김성준 on 2016. 10. 27..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Contacts+CoreDataClass.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)saveContact:(id)sender;
- (IBAction)findContact:(id)sender;

@end

