//
//  PagesCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 26.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PagesCollectionViewController.h"
#import "PagesCollectionViewCell.h"
#import "PictureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MagazineItem.h"

static NSString * const pictureReuseIdentifier = @"Cell";

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface PagesCollectionViewController ()
@property(strong, nonatomic) AVAudioPlayer* player;
@end

@implementation PagesCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PagesCollectionViewCell* cell = (PagesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:pictureReuseIdentifier forIndexPath:indexPath];
    
    MagazineItem* page = self.pagesArray[indexPath.row];
    cell.pageNumber.layer.masksToBounds = YES;
    cell.pageNumber.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row + 1)];
    cell.pageNumber.layer.cornerRadius = 5;
    cell.pageImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile: [DOCUMENTS stringByAppendingPathComponent:page.imageFile ]]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)    collectionView:(UICollectionView*) collectionView
  didSelectItemAtIndexPath:(NSIndexPath*) indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToPage" object:
     indexPath];
}


@end
