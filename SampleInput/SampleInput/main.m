//
//  main.m
//  SampleInput
//
//  Created by 개발자 on 2016. 10. 10..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Logger *logger = [Logger new];
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                          target:logger
                                                        selector:@selector(sayOuch:)
                                                        userInfo:nil
                                                         repeats:YES];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}
