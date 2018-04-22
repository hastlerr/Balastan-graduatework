//
//  LetterCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 2/24/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "LetterCollectionViewController.h"
#import "LetterItem.h"
#import "LetterCollectionViewCell.h"

@interface LetterCollectionViewController ()

@property (nonatomic, assign) BOOL didAppear;

@end

@implementation LetterCollectionViewController

static NSString * const letterReuseIdentifier = @"LetterCollectionIdentifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL) animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.letterIndex
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
    return self.letterArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView*) collectionView
                  cellForItemAtIndexPath:(NSIndexPath*) indexPath
{
    LetterCollectionViewCell* cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:letterReuseIdentifier
                                              forIndexPath:indexPath];
    
    cell.letter=self.letterArray[indexPath.row];
    
    return cell;
}

- (NSInteger) showNextLetter{
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.letterIndex + 1
                        inSection:0];
    
    if (indexPath.row >= 0 && indexPath.row <=self.letterArray.count - 1)
    {
        self.letterIndex = self.letterIndex + 1;
        
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
    }
    
    return self.letterIndex;
}


- (NSInteger) showPreviousLetter{
    
    NSIndexPath* indexPath =
    [NSIndexPath indexPathForItem:self.letterIndex - 1
                        inSection:0];
    
    if (indexPath.row >= 0)
    {
        self.letterIndex = self.letterIndex - 1;
        
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
    }
    
    return self.letterIndex;
}

#pragma mark <UICollectionViewDelegate>

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        if (self.didAppear)
        {
            CGRect cellScreenRect=[self.view.window convertRect:cell.frame fromView:self.collectionView];
            if(CGRectIntersectsRect(cellScreenRect, self.view.bounds)){
                self.letterIndex = indexPath.row;
                [self.delegate letterCollectionController:self
                                  didScrollToLetterAtIndex:indexPath.row];
                
                [self.delegate playAudioForIndex:indexPath.row];
            }
            
        }
    }
}

@end
