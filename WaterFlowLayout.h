//
//  WaterFlowLayout.h
//  photo-gallery
//
//  Created by MacBook Air on 5/27/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic, strong) NSDictionary *layoutInfo;

@end
