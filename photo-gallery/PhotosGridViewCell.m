//
//  PhotosGridViewCell.m
//  photo-gallery
//
//  Created by MacBook Air on 5/25/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import "PhotosGridViewCell.h"

@implementation PhotosGridViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.hidden = true;
    self.activityIndicator.hidden = false;
}
@end
