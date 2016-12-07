//
//  FoodViewController.m
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 16..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "FoodViewController.h"
#import "SWRevealViewController.h"
@import GoogleMaps;

@interface FoodViewController ()

@end

@implementation FoodViewController{
    GMSMapView *mapView;
    CLLocationManager *locationManager;
    float latitude;
    float longitude;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    latitude = locationManager.location.coordinate.latitude;
    longitude = locationManager.location.coordinate.longitude;
    
    NSLog(@"Lat : %f  Long : %f",latitude,longitude);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:15];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
//    GMSMarker *marker = [GMSMarker new];
//    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
//    marker.title = @"My Location";
//    marker.snippet = @"here I am";
//    marker.map = mapView;
    
    [self callTmapAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callTmapAPI{
    
    NSString *url = @"https://apis.skplanetx.com/tmap/pois/search/around";
    
    //    apiKey = 47be8fe9-5a9c-3193-836c-cbd939a3753e
    //    Example of API call:
    /*
       https://apis.skplanetx.com/tmap/pois/search/around?centerLon=127.05551147&centerLat=37.54484953&count=&page=&reqCoordType=WGS84GEO&callback=&multiPoint=&radius=1&categories=식음료&resCoordType=WGS84GEO&version=1
    */
    
 
//    여기서부터 리퀘스트객체의 헤더에 API key와 그 외 여럿 담고 시작하자.
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"47be8fe9-5a9c-3193-836c-cbd939a3753e" forHTTPHeaderField:@"appKey"];
    
    
    [manager GET:url
      parameters:@{
                   @"version":@"1",
                   @"centerLat":[NSString stringWithFormat:@"%f",latitude],
                   @"centerLon":[NSString stringWithFormat:@"%f",longitude],
                   @"categories":@"식음료",
                   @"reqCoordType":@"WGS84GEO",
                   @"resCoordType":@"WGS84GEO"
                 }
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSString *receivedDataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"API result : %@",receivedDataString);
             
//           iPhone Device에서 로그 보려고 만든 것
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"API RESULT" message:receivedDataString preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
             [alert addAction:cancelAction];
             [self presentViewController:alert animated:false completion:nil];
             
             NSError *error;
             NSDictionary *apiDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"%@", error);
             
         }
     ];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
