//
//  PhotosGridView.h
//  photo-gallery
//
//  Created by MacBook Air on 5/25/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomFlowLayout.h"
#import "DataWrapper.h"

@interface PhotosGridView : UICollectionViewController<UIScrollViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) DataWrapper* dataWrapper;
@property (nonatomic) CustomFlowLayout* aFlowLayout;

@end
