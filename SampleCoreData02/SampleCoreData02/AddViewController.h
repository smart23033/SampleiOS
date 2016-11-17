//
//  AddViewController.h
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddressBook+CoreDataClass.h"


@interface AddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

- (IBAction)touchUpCancel:(id)sender;
- (IBAction)touchUpSave:(id)sender;

@end

