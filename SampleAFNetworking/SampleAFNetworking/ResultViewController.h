//
//  ViewController.h
//  SampleAFNetworking
//
//  Created by 김성준 on 2016. 11. 4..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface ResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;

@end

