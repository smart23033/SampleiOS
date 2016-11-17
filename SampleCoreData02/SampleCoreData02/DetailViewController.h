//
//  DetailViewController.h
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBook+CoreDataClass.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@property (strong, nonatomic) AddressBook *address;

@end

