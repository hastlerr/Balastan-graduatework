//
//  MainPageCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 26.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MainPageCollectionViewController.h"
#import "MainPageCollectionViewCell.h"
#import "MagazineItem.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface MainPageCollectionViewController ()
@property (assign, nonatomic) BOOL textHidden;
@end

@implementation MainPageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollToPage:)
                                                 name:@"scrollToPage"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textHidden:)
                                                 name:@"textHidden"
                                               object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainPageCollectionViewCell* cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MagazineItem* page = self.pagesArray[indexPath.row];
    
    cell.textOutlet.hidden = self.textHidden;
    if(self.textHidden){
        [cell.textHidenOutlet setImage:[UIImage imageNamed:@"menu_up"]
                               forState:UIControlStateNormal];
    }else{
        [cell.textHidenOutlet setImage:[UIImage imageNamed:@"menu_down"]
                              forState:UIControlStateNormal];
    }
    cell.textHidenOutlet.layer.cornerRadius = 10;
    cell.textOutlet.text = page.text;
    //[cell.textOutlet setUserInteractionEnabled:NO];
    cell.mainPageOutlet.image = [UIImage imageWithData:[NSData dataWithContentsOfFile: [DOCUMENTS stringByAppendingPathComponent:page.imageFile ]]];
    
    return cell;

}

- (void) scrollToPage:(NSNotification*) notification{
    
    [self.collectionView layoutIfNeeded];
    NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:[notification.object row] inSection:currentItem.section];
    
    [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)textHidden:(NSNotification*) notification{
    UITextView *textOutlet = notification.object;
    self.textHidden = textOutlet.layer.hidden;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenPagesContainer" object:
     nil];
}


#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 1;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    
    int numberOfCellInRowVertical = 1;
    
    CGFloat cellHeight =  [[UIScreen mainScreen] bounds].size.height/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (void)     collectionView:(UICollectionView *)collectionView
   didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playAudioNotification" object:
     indexPath];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
