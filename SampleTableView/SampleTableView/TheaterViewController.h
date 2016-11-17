//
//  TheaterViewController.h
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 25..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TheaterViewController : UIViewController

@property (nonatomic) NSDictionary *param;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UINavigationItem *navibar;

@end
