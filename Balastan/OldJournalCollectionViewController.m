//
//  OldJournalCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 13.06.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "OldJournalCollectionViewController.h"
#import "OldJournalCollectionViewCell.h"
#import "MagazineItem.h"
@interface OldJournalCollectionViewController ()

@end

@implementation OldJournalCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.journal.pages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OldJournalCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MagazineItem* page = self.journal.pages[indexPath.row];
    
    return [cell getournalCell:page];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 1;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    
    float numberOfCellInRowVertical = 0.4;
    
    CGFloat cellHeight =  [[UIScreen mainScreen] bounds].size.height/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}

@end
