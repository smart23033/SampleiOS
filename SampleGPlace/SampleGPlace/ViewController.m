#import "ViewController.h"
@import GooglePlacePicker;

@interface ViewController ()
// Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.

@end

@implementation ViewController {
    GMSPlacePicker *_placePicker;
}

@synthesize nameLabel,addressLabel;

// Add a UIButton in Interface Builder, and connect the action to this funct

- (IBAction)pickPlace:(UIButton *)sender {
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.788204, -122.411937);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            self.nameLabel.text = place.name;
            self.addressLabel.text = [[place.formattedAddress
                                       componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
        } else {
            self.nameLabel.text = @"No place selected";
            self.addressLabel.text = @"";
        }
    }];
}
@end
