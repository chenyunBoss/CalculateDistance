//
//  NSTimer+BlockSupport.h
//  TEST
//
//  Created by chenyun on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockSupport)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;

@end
