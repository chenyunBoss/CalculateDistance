//
//  TestView.m
//  TEST
//
//  Created by chenyun on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#define row 5

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 8;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor lightGrayColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 200 + row, row);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, 200 + row, self.bounds.size.height - row);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {4,4};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    
    CGContextDrawPath(currentContext, kCGPathStroke);
//    CGContextStrokePath(currentContext);
    // 关闭图像
//    CGContextClosePath(currentContext);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(200, 0)];
    [path addArcWithCenter:CGPointMake(200 + row, 0) radius:row startAngle:M_PI endAngle:M_PI * 2 clockwise:NO];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path addArcWithCenter:CGPointMake(200 + row, self.bounds.size.height) radius:row startAngle:0 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.path = path.CGPath;
    self.layer.mask = layer;
    
}

@end
