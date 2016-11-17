//
//  main.m
//  SampleDelegate
//
//  Created by 김성준 on 2016. 10. 14..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainView.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        MainView *mainView = [MainView new];
        [mainView startDelegate:10 withTwo:30];
        [mainView executeDelegate];
    }
    return 0;
}
