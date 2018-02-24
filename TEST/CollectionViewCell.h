//
//  CollectionViewCell.h
//  TEST
//
//  Created by chenyun on 2018/1/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, copy) NSString *value;

@end
