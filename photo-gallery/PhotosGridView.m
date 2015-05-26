//
//  PhotosGridView.m
//  photo-gallery
//
//  Created by MacBook Air on 5/25/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import "PhotosGridView.h"
#import "PhotosGridViewCell.h"


@interface PhotosGridView ()

@end

@implementation PhotosGridView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UINib *nibForTheCell = [UINib nibWithNibName:@"PhotosGridViewCell" bundle:nil];
    [self.collectionView registerNib:nibForTheCell forCellWithReuseIdentifier:reuseIdentifier];
    
    // Register cell classes
    //[self.collectionView registerClass:[PhotosGridViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(PhotosGridView *)init {
    NSLog(@"initalizin photos grid view");
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(150, 140)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [super initWithCollectionViewLayout:aFlowLayout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"asking for sections");
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"asking for number of items");
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSLog(@"im in loading cell %li", (long)indexPath.row);
    // Configure the cell
    NSURL *baseURL = [NSURL URLWithString:[self generateURLString]];
    [[cell imageView] sd_setImageWithURL:(baseURL) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = [self decideSize: image];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, size.width, size.height);
        cell.imageView.hidden = false;
        cell.activityIndicator.hidden = true;
//        NSLog(@"\nImageSize: (%f, %f)", image.size.width, image.size.height);
//        NSLog(@"\nCellSize: (%f, %f)", size.width, size.height);
    }];
    return cell;
}

-(NSString *) generateURLString {
    int width = 250 + arc4random_uniform(600);
    int height = 300 + arc4random_uniform(600);
    return [NSString stringWithFormat:@"http://lorempixel.com/%i/%i/", width, height];
}

-(CGSize) decideSize: (UIImage *)image {
    CGSize s;
    int minWidth = (self.view.frame.size.width - 200) / 2;
    s.width = MIN(minWidth, image.size.width);
    if (s.width != image.size.width) {
        s.height = (image.size.height * s.width) / image.size.width;
    }
    return s;
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Make cell same width as application frame and 250 pixels tall.
//    NSLog(@"im in size for cell %li", (long)indexPath.row);
//    return CGSizeMake(self.view.frame.size.width, 250);
//}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
