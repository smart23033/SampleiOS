//
//  ResultViewController.h
//  SampleViewDelivery01
//
//  Created by 김성준 on 2016. 10. 17..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController{
    @public
    NSString *paramEmail;
    BOOL paramUpdate;
    int paramInterval;
}

@property (weak, nonatomic) IBOutlet UILabel *resultEmail;
@property (weak, nonatomic) IBOutlet UILabel *resultUpdate;
@property (weak, nonatomic) IBOutlet UILabel *resultInterval;
- (IBAction)onBack:(UIButton *)sender;

@end
