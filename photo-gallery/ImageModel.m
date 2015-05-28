//
//  ImageModel.m
//  photo-gallery
//
//  Created by MacBook Air on 5/27/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageModel.h"

@implementation ImageModel

-(id)initWithImage: (NSURL*)imageUrl
{
    self = [super init];
    if (self) {
        self.imageData = nil;
        self.imageUrl = imageUrl;
        self.imageResize = CGSizeZero;
        self.isPortrait = false;
    }
    return self;
}

-(void) updateResizeImage {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    self.imageResize = [self decideSize:[self imageData]];
    self.isPortrait = UIDeviceOrientationIsPortrait(orientation);
}
-(CGSize) getImageResize {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (self.isPortrait == UIDeviceOrientationIsPortrait(orientation)) {
        return self.imageResize;
    } else {
        return [self decideSize:[self imageData]];
    }
}


-(CGSize) decideSize: (UIImage *)image {
    CGSize s;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    int minWidth = 0;
    if(UIDeviceOrientationIsPortrait(orientation)) {
        minWidth = ([[UIScreen mainScreen] bounds].size.width) / 2;
    } else {
        minWidth = ([[UIScreen mainScreen] bounds].size.width) / 3;
    }
    
    s.width = minWidth;
    if (s.width != image.size.width) {
        s.height = (image.size.height * s.width) / image.size.width;
    }
    return s;
}


@end