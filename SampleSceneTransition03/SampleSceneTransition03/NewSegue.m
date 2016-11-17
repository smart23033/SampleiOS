//
//  NewSegue.m
//  SampleSceneTransition03
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "NewSegue.h"


@interface NewSegue ()

@end

@implementation NewSegue

-(void)perform{
   
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    
    [UIView transitionFromView:source.view toView:destination.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
}

@end
