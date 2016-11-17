//
//  FoodViewController.h
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 16..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface FoodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (void)callTmapAPI;
@end
