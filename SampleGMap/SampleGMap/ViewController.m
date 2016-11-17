//
//  ViewController.m
//  SampleGMap
//
//  Created by 김성준 on 2016. 10. 25..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;

@interface ViewController ()

@end

@implementation ViewController{
    GMSMapView *mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:6];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    GMSMarker *marker = [GMSMarker new];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
