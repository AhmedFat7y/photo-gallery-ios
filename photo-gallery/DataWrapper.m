//
//  DataWrapper.m
//  photo-gallery
//
//  Created by MacBook Air on 5/28/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import "DataWrapper.h"
#import "ImageModel.h"
#import <UIKit/UIKit.h>
@implementation DataWrapper

-(instancetype)init {
    if (self = [super init]) {
        self.imagesArray = [[NSMutableArray alloc] init];
        [self addImages:30];
    }
    return self;
}

+(DataWrapper *)singleton {
    static DataWrapper* singleton = nil;
        
    if (singleton == nil)
    {
        singleton = [[DataWrapper alloc] init];
    }
    
    return singleton;
}
-(void) addImages:(NSInteger) count {
    for(int i =0;i < count; i++) {
        NSURL *baseURL = [NSURL URLWithString:[DataWrapper generateURLString]];
        ImageModel* model = [[ImageModel alloc] initWithImage:nil imageUrl:baseURL imageResize:CGSizeZero];
        [[self imagesArray] addObject: model];
    }
}

+(void) addImages:(NSInteger) count {
    [[DataWrapper singleton] addImages:count];
}

+(NSInteger) count {
    return [[DataWrapper.singleton imagesArray] count];
}

+(NSString *) generateURLString {
    int width = 250 + arc4random_uniform(600);
    int height = 300 + arc4random_uniform(600);
    return [NSString stringWithFormat:@"http://lorempixel.com/%i/%i/", width, height];
}

+(ImageModel*) ImageModelAtIndex: (NSIndexPath*) indexPath {
    return [[DataWrapper.singleton imagesArray] objectAtIndex:[indexPath row]];
}

@end
