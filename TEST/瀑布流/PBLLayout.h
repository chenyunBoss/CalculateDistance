//
//  PBLLayout.h
//  TEST
//
//  Created by chenyun on 2017/10/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBLLayout;

/**
 * 代理传值
 */
@protocol PBLLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(PBLLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 设置瀑布流的列数
 */
- (CGFloat)columnCountInWaterflowLayout:(PBLLayout *)waterflowLayout;
/**
 * 设置瀑布流列的间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(PBLLayout *)waterflowLayout;
/**
 * 设置瀑布流行的间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(PBLLayout *)waterflowLayout;
/**
 * 设置瀑布流边缘（四周）的间隙
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(PBLLayout *)waterflowLayout;
@end

@interface PBLLayout : UICollectionViewFlowLayout

@property (nonatomic , weak) id<PBLLayoutDelegate> delegate;

@end
