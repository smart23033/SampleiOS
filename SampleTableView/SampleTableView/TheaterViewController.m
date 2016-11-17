
#import "TheaterViewController.h"

@implementation TheaterViewController

@synthesize map,navibar,param;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    navibar.title = (NSString *)[param objectForKey:@"상영관명"];
    
    CLLocationDegrees lat = [(NSString *)[param objectForKey:@"위도"] doubleValue];
    CLLocationDegrees lng = [(NSString *)[param objectForKey:@"경도"] doubleValue];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, lng);
    
    CLLocationDistance regionRadius = 500;
    
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius);
    
    MKPointAnnotation *point = [MKPointAnnotation new];
    point.coordinate = location;
    
    [self.map setRegion:coordinateRegion animated:true];
    [self.map addAnnotation:point];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
