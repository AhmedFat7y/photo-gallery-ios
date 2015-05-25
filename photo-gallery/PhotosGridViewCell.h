//
//  PhotosGridViewCell.h
//  photo-gallery
//
//  Created by MacBook Air on 5/25/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface PhotosGridViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
