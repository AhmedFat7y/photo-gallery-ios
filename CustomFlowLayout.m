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
#import "DataWrapper.h"

@interface CustomFlowLayout()
@property (nonatomic) NSInteger numberOfColumns;
@end

@implementation CustomFlowLayout


- (id) init {
    self = [super init];
    if(self) {
        _numberOfColumns = 2;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)prepareLayout {
    NSLog(@"prepareing layout");
    [super prepareLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"layoutAttributesForElementsInRect");
    NSArray * layoutInfo = [super layoutAttributesForElementsInRect:rect];
    for (int i =0; i < layoutInfo.count; i++) {
        UICollectionViewLayoutAttributes* attributes = layoutInfo[i];
        ImageModel* model = [DataWrapper ImageModelAtIndex:attributes.indexPath];
        CGSize tempSize = attributes.frame.size;
        float newY;
        if (model.imageData) {
            tempSize = [model getImageResize];
        }
        if (i > 1) {
            UICollectionViewLayoutAttributes* previousAttributes = layoutInfo[i - 2];
            newY = previousAttributes.frame.origin.y + previousAttributes.frame.size.height + self.minimumLineSpacing;
            
        } else {
            newY = attributes.frame.origin.y;
        }
        
        attributes.frame = CGRectMake(attributes.frame.origin.x, newY, tempSize.width, tempSize.height);
//        attributes.frame = CGRectMake(5, 5, attributes.frame.size.width, attributes.frame.size.height);
        
    }
    //NSLog(@"%@", layoutInfo);
    return layoutInfo;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"layoutAttributesForItemAtIndexPath");
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}


@end
