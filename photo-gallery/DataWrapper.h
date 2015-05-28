//
//  DataWrapper.h
//  photo-gallery
//
//  Created by MacBook Air on 5/28/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
@interface DataWrapper : NSObject

@property (nonatomic) NSMutableArray* imagesArray;
+ (DataWrapper*) singleton;

+(NSInteger) count;
+(ImageModel*) ImageModelAtIndex: (NSIndexPath*) indexPath;
+(void) addImages:(NSInteger) count;

@end
