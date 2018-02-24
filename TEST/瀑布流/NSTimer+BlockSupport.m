//
//  NSTimer+BlockSupport.m
//  TEST
//
//  Created by chenyun on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer (BlockSupport)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}


@end
