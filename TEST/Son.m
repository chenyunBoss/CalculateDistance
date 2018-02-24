//
//  Son.m
//  TEST
//
//  Created by chenyun on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"BBB");
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        [self fatherMethod];
    }
    return self;
}

- (void)fatherMethod {
    [super fatherMethod];
    if (self.flag) {
        NSLog(@"sonMethod");
    }
}

@end
