//
//  TestCell.m
//  TEST
//
//  Created by chenyun on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}  

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
