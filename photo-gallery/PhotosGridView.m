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

+(PhotosGridView *)init {
    NSLog(@"initalizin photos grid view");
    CustomFlowLayout* aFlowLayout = [[CustomFlowLayout alloc] init];
    aFlowLayout.minimumInteritemSpacing = 0;
    aFlowLayout.minimumLineSpacing = 1;
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    PhotosGridView* temp = [[PhotosGridView alloc] initWithCollectionViewLayout:aFlowLayout];
    return temp;
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
            [model updateResizeImage];
            cell.activityIndicator.hidden = true;
            cell.imageView.hidden = false;
            NSLog(@"loaded image: %li", (long)indexPath.row);
            //[[self aFlowLayout] invalidateLayout];
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
        return [model getImageResize];
    } else {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        int minWidth = 0;
        if(UIDeviceOrientationIsPortrait(orientation)) {
            minWidth = (self.collectionView.frame.size.width) / 2;
        } else {
            minWidth = (self.collectionView.frame.size.width) / 3;
        }
        return CGSizeMake(minWidth, minWidth);
    }
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


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
 {
     [self.collectionView.collectionViewLayout invalidateLayout];
 }

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
