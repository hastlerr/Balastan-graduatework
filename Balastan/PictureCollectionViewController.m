//
//  PictureCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PictureCollectionViewController.h"
#import "PictureItem.h"
#import "PictureCollectionViewCell.h"

@interface PictureCollectionViewController ()
@property (nonatomic, assign) BOOL didAppear;
@end

@implementation PictureCollectionViewController

static NSString * const pictureReuseIdentifier = @"PictureCollectionIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL) animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.pictureIndex
                        inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:NO];
    
    self.didAppear = YES;
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UICollectionViewFlowLayout* layout =
    (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    layout.itemSize = self.view.bounds.size;
    self.collectionView.pagingEnabled = YES;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger) collectionView:(UICollectionView*) collectionView
      numberOfItemsInSection:(NSInteger) section
{
    return self.pictureArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView*) collectionView
                  cellForItemAtIndexPath:(NSIndexPath*) indexPath
{
    PictureCollectionViewCell* cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:pictureReuseIdentifier
                                              forIndexPath:indexPath];
    
    cell.picture=self.pictureArray[indexPath.row];
    
    return cell;
}

- (NSInteger) showNextPicture{
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.pictureIndex + 1
                        inSection:0];
    
    if (indexPath.row >= 0 && indexPath.row <=self.pictureArray.count - 1)
    {
        self.pictureIndex = self.pictureIndex + 1;
        
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
    }
    
    return self.pictureIndex;
}


- (NSInteger) showPreviousPicture{
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.pictureIndex - 1
                        inSection:0];
    
    if (indexPath.row >= 0)
    {
        self.pictureIndex = self.pictureIndex - 1;
        
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
    }
    
    return self.pictureIndex;
}

#pragma mark <UICollectionViewDelegate>

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        if (self.didAppear)
        {
            CGRect cellScreenRect=[self.view.window convertRect:cell.frame fromView:self.collectionView];
            if(CGRectIntersectsRect(cellScreenRect, self.view.bounds)){
                self.pictureIndex = indexPath.row;
                [self.delegate pictureCollectionController:self
                                  didScrollToLetterAtIndex:indexPath.row];
                
                [self.delegate playAudioForIndex:indexPath.row];
            }
        }
    }
}

@end
