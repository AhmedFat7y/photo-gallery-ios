//
//  CustomFlowLayout.m
//  photo-gallery
//
//  Created by MacBook Air on 5/27/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import "CustomFlowLayout.h"
#import "PhotosGridView.h"
#import "PhotosGridViewCell.h"

@interface CustomFlowLayout()

@end

@implementation CustomFlowLayout


- (id) init {
    
    self = [super init];
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return self;
}

- (void)prepareLayout {
    NSLog(@"prepareing layout");
    [super prepareLayout];
    //NSLog(@"%@",[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"layoutAttributesForElementsInRect");
    NSArray * layoutInfo = [super layoutAttributesForElementsInRect:rect];
    //NSLog(@"%@", layoutInfo);
    return layoutInfo;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"layoutAttributesForItemAtIndexPath");
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

@end
