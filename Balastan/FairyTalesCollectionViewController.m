//
//  FairyTalesCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 03.05.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "FairyTalesCollectionViewController.h"
#import "FairyTaleItem.h"
#import "FairyTaleCollectionViewCell.h"
#import "FairyTaleViewController.h"
static NSString* const keyShowFairyTaleSegue =  @"showFairyTaleSegue";

@interface FairyTalesCollectionViewController ()

@property(strong, nonatomic) NSArray<FairyTaleItem*>* fairyTaleArray;
@property(assign,nonatomic) NSInteger fairyTaleIndex;
@property(strong, nonatomic) AVAudioPlayer* player;

@end

@implementation FairyTalesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* fairyTalesPath =
    [[NSBundle mainBundle] pathForResource:@"Fairytales" ofType:@"json"];
    
    NSData* fairyTalesData =
    [NSData dataWithContentsOfFile:fairyTalesPath];
    
    self.fairyTaleArray =
    [FairyTaleItem arrayOfModelsFromData:fairyTalesData
                                   error:nil];
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:@"j_kyrgyz_el_jomok" withExtension:@".m4a"];
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];

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
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *fairyCover = [ NSArray arrayWithObjects:@"m_akylduu_bala",@"m_balasy_menen_atasy",@"m_nan_jonyndo",@"m_yrys_aldy_yntymak", @"m_altyn_kush", @"m_ubadaga_bek_jigit",nil];
    FairyTaleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.fairyTeleCoverImage.clipsToBounds = YES;
    cell.fairyTeleCoverImage.layer.cornerRadius = 20;
    cell.fairyTeleCoverImage.image  = [UIImage imageNamed:[fairyCover objectAtIndex:indexPath.row]];
    return cell;
}





#pragma mark - Navigation

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell =
    [self.collectionView cellForItemAtIndexPath:indexPath];
   // FairyTaleItem* fairyTale=self.fairyTaleArray[self.fairyTaleIndex];
    [self performSegueWithIdentifier:keyShowFairyTaleSegue
                              sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];
    
    if([segue.identifier isEqualToString:keyShowFairyTaleSegue]){
        
        UICollectionViewCell* cell = (UICollectionViewCell*)sender;
        
        NSIndexPath* idxPath = [self.collectionView indexPathForCell:cell];
        FairyTaleViewController* fairyTaleController = segue.destinationViewController;
        
        fairyTaleController.fairyTale = [_fairyTaleArray objectAtIndex:idxPath.row];
    }
}




#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 2;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width-120)/numberOfCellInRow;
    
    int numberOfCellInRowVertical = 2;
    
    CGFloat cellHeight =  ([[UIScreen mainScreen] bounds].size.height-100)/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}


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
