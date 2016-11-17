//
//  DetailViewController.h
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 21..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieVO.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>{
    MovieVO *mvo;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navibar;
@property (weak, nonatomic) IBOutlet UIWebView *wv;
@property (strong, nonatomic) MovieVO *mvo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
