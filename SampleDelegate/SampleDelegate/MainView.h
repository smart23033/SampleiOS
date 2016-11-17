//
//  MainView.h
//  SampleDelegate
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Addition.h"

@interface MainView : NSObject<AdditionDelegate>{
    Addition *addition;
}

-(void) startDelegate:(int)one withTwo:(int)two;
-(void) executeDelegate;

@end
