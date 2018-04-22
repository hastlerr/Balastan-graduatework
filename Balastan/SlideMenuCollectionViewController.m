//
//  SlideMenuCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "SlideMenuCollectionViewController.h"
#import "SlideMenuCollectionViewCell.h"
#import "PictureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SlideMenuCollectionViewController ()
@property(strong, nonatomic) AVAudioPlayer* player;
@end

@implementation SlideMenuCollectionViewController

static NSString * const keyShowPictureSegue = @"showPictureSegue";
static NSString * const pictureReuseIdentifier = @"pictureCell";


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.tag==0){
        NSURL* url=[[NSBundle mainBundle] URLForResource:@"jer_jemish" withExtension:@".m4a"];
        self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.player play];
    }
    else if (self.tag==1){
        NSURL* url=[[NSBundle mainBundle] URLForResource:@"japayi_janybarlar" withExtension:@".m4a"];
        self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.player play];
    }
    else if (self.tag==2){
        NSURL* url=[[NSBundle mainBundle] URLForResource:@"unaalar" withExtension:@".m4a"];
        self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.player play];
    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];
    
    if ([segue.identifier isEqualToString:keyShowPictureSegue])
    {
        PictureViewController* pictureController =
        segue.destinationViewController;
        
        SlideMenuCollectionViewCell* cell =
        (SlideMenuCollectionViewCell*)sender;
        
        pictureController.pictureArray = self.pictureArray;
        
        pictureController.pictureIndex =
        [self.collectionView indexPathForCell:cell].row;
    }
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictureArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SlideMenuCollectionViewCell* cell = (SlideMenuCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:pictureReuseIdentifier forIndexPath:indexPath];
    
    PictureItem* picture = self.pictureArray[indexPath.row];
    
    cell.pictureImage = [UIImage imageNamed:picture.pictureImage];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)    collectionView:(UICollectionView*) collectionView
  didSelectItemAtIndexPath:(NSIndexPath*) indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath
                                        animated:NO];
    
    SlideMenuCollectionViewCell* cell =
    (SlideMenuCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:keyShowPictureSegue sender:cell];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 7;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    
    int numberOfCellInRowVertical = 7;
    
    CGFloat cellHeight =  [[UIScreen mainScreen] bounds].size.height/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}


@end
