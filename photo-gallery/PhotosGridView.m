//
//  PhotosGridView.m
//  photo-gallery
//
//  Created by MacBook Air on 5/25/15.
//  Copyright (c) 2015 Unlimited Blade Works. All rights reserved.
//

#import "PhotosGridView.h"
#import "PhotosGridViewCell.h"
#import "CustomFlowLayout.h"
#import "ImageModel.h"


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
    self.collectionView.delegate = self;
    
    self.dataWrapper = [[DataWrapper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(PhotosGridView *)init {
    NSLog(@"initalizin photos grid view");
    self.aFlowLayout = [[CustomFlowLayout alloc] init];
    [self.aFlowLayout setItemSize:CGSizeMake(100, 140)];
    [self.aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [super initWithCollectionViewLayout:self.aFlowLayout];
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
    return [DataWrapper count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    ImageModel *model = [DataWrapper ImageModelAtIndex:indexPath];
    if (model.imageData == nil)
    {
        NSLog(@"im in loading cell %li", (long)indexPath.row);
        
        NSURL *baseURL =  model.imageUrl;
        [[cell imageView] sd_setImageWithURL:(baseURL) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //        CGSize size = [self decideSize: image];
            //        cell.imageView.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, size.width, size.height);
            model.imageData = image;
            model.imageResize = [self decideSize:cell.imageView.image];
            cell.activityIndicator.hidden = true;
            cell.imageView.hidden = false;
            NSLog(@"loaded image: %li", (long)indexPath.row);
            [[self aFlowLayout] invalidateLayout];
        }];
    } else {
        cell.imageView.image = model.imageData;
        cell.imageView.hidden = false;
        cell.activityIndicator.hidden = true;
        //[[self aFlowLayout] invalidateLayout];
    }
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageModel *model = [DataWrapper ImageModelAtIndex:indexPath];
    if (model.imageData != nil) {
        return model.imageResize;
    } else {
        return CGSizeMake(100, 140);
    }
}


-(CGSize) decideSize: (UIImage *)image {
    CGSize s;
    int minWidth = (self.collectionView.frame.size.width - 200) / 2;
    s.width = MIN(minWidth, image.size.width);
    if (s.width != image.size.width) {
        s.height = (image.size.height * s.width) / image.size.width;
    }
    return s;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [super scrollViewDidScroll:scrollView];
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // we are at the end
        [DataWrapper addImages:10];
        [[self collectionView] reloadData];
    }
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
