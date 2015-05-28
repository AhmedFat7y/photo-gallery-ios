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

-(id)initWithImage: (UIImage*)imageData
                    imageUrl: (NSURL*)imageUrl
                 imageResize: (CGSize) imageResize
{
    self = [super init];
    if (self) {
        self.imageData = imageData;
        self.imageUrl = imageUrl;
        self.imageResize = imageResize;
    }
    return self;
}

@end