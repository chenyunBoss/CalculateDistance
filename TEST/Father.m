//
//  Father.m
//  TEST
//
//  Created by chenyun on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Father.h"

@implementation Father

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"AAAA");
    }
    return self;
}

- (void)fatherMethod {
    NSLog(@"fatherMethod");
    self.flag = YES;
    return;
//    NSLog(@"fatherMethod2");
}

@end
