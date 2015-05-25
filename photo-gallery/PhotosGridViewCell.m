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
    NSURL *baseURL = [NSURL URLWithString:[self generateURLString]];
    NSLog(@"\nCreating cell --- ");
    [[self imageView] sd_setImageWithURL:(baseURL) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = [self decideSize: image];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        self.imageView.hidden = false;
        self.activityIndicator.hidden = true;
        NSLog(@"\nImageSize: (%f, %f)", image.size.width, image.size.height);
        NSLog(@"\nCellSize: (%f, %f)", size.width, size.height);
    }];
}

-(NSString *) generateURLString {
    int width = 250 + arc4random_uniform(600);
    int height = 300 + arc4random_uniform(600);
    return [NSString stringWithFormat:@"http://lorempixel.com/%i/%i/", width, height];
}

-(CGSize) decideSize: (UIImage *)image {
    CGSize s;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int minWidth = (screenRect.size.width - 100) / 2;
    s.width = MIN(minWidth, image.size.width);
    if (s.width != image.size.width) {
        s.height = (image.size.height * s.width) / image.size.width;
    }
    return s;
    
}

@end
