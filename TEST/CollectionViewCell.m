//
//  CollectionViewCell.m
//  TEST
//
//  Created by chenyun on 2018/1/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setValue:(NSString *)value {
    _value = value;
    if ([_value isEqualToString:@"1"]) {
        self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.bgView.layer.shadowRadius = 3;
        self.bgView.layer.shadowOpacity = 1;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    } else {
        self.bgView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.bgView.layer.shadowRadius = 3;
        self.bgView.layer.shadowOpacity = 0;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    }
}

@end
