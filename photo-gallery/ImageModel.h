//
//  ImageModel.h
//  photo-gallery
//
//  Created by MacBook Air on 5/27/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#ifndef photo_gallery_ImageModel_h
#define photo_gallery_ImageModel_h

#import <UIKit/UIKit.h>

@interface ImageModel : NSObject

@property (nonatomic) NSURL* imageUrl;
@property (nonatomic) UIImage* imageData;
@property (nonatomic) CGSize imageResize;

-(id)initWithImage: (UIImage*)imageData
          imageUrl: (NSURL*)imageUrl
       imageResize: (CGSize) imageResize;

@end

#endif
