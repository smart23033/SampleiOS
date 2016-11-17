//
//  ViewController.m
//  SampleAFNetworking
//
//  Created by 김성준 on 2016. 11. 4..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSString *url = @"http://api.openweathermap.org/data/2.5/forecast/city";
    NSString *url = @"http://api.openweathermap.org/data/2.5/weather";

//    apiKey = 7123bf3dbc3ab29da45d78301b0f2e59
//    Example of API call:
//    api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=1111111111
//    api.openweathermap.org/data/2.5/weather?q=London
    
    [manager GET:url
      parameters:@{
//                   @"id":@"524901",
                   @"APPID":@"7123bf3dbc3ab29da45d78301b0f2e59",
                   @"q":_locationLabel.title,
                   @"units":@"metric"}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
//             NSLog(@"%@", responseObject);
             
             NSString *receivedDataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"API result : %@",receivedDataString);
             
             NSError *error;
             NSDictionary *apiDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
             
             NSMutableArray *weather = (NSMutableArray *)[apiDictionary valueForKey:@"weather"];
             NSDictionary *main = (NSDictionary *)[apiDictionary valueForKey:@"main"];
             NSDictionary *wind = (NSDictionary *)[apiDictionary valueForKey:@"wind"];

             NSString *temp = [[main valueForKey:@"temp"] stringValue];
             NSString *humidity = [[main valueForKey:@"humidity"] stringValue];
             NSString *description = (NSString *)[weather[0] valueForKey:@"description"];
             NSString *windSpeed = [[wind valueForKey:@"speed"] stringValue];
             
             NSLog(@"weather : %@",weather[0]);
             NSLog(@"main : %@",main);
             NSLog(@"desc : %@",description);
             NSLog(@"temp : %@",temp);
             NSLog(@"humidity : %@%%",humidity);
             NSLog(@"windSpeed : %@m/s",windSpeed);
             
             _temperatureLabel.text = temp;
             _descriptionLabel.text = description;
             _humidityLabel.text = humidity;
             _windLabel.text = windSpeed;

             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"%@", error);
         }
     ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
