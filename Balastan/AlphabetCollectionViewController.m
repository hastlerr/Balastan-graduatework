//
//  AlphabetCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 2/20/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "AlphabetCollectionViewController.h"
#import "AlphabetCollectionViewCell.h"
#import "LetterViewController.h"

#import "LetterItem.h"

@interface AlphabetCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(strong, nonatomic) NSArray <LetterItem*>* letterArray;
@property (nonatomic, strong) NSIndexPath* letterIndexPath;

@end

@implementation AlphabetCollectionViewController

static NSString * const keyShowLetterSegue     = @"showLetterSegue";
static NSString * const letterReuseIdentifier  = @"letterCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString* lettersPath =
    [[NSBundle mainBundle] pathForResource:@"Letters" ofType:@"json"];
    
    NSData* lettersData =
    [NSData dataWithContentsOfFile:lettersPath];
    
    self.letterArray =
    [LetterItem arrayOfModelsFromData:lettersData
                                error:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];
    
    if ([segue.identifier isEqualToString:keyShowLetterSegue])
    {
        LetterViewController* letterController =
        segue.destinationViewController;
        
        AlphabetCollectionViewCell* cell =
        (AlphabetCollectionViewCell*)sender;
        
        letterController.letterArray = self.letterArray;
        
        letterController.letterIndex =
        [self.collectionView indexPathForCell:cell].row;
    }
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.letterArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AlphabetCollectionViewCell* cell = (AlphabetCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:letterReuseIdentifier forIndexPath:indexPath];
    
    LetterItem* letter = self.letterArray[indexPath.row];
    
    cell.letterImage = [UIImage imageNamed:letter.letterImage];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>


- (void)    collectionView:(UICollectionView*) collectionView
  didSelectItemAtIndexPath:(NSIndexPath*) indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath
                                        animated:NO];
    
    AlphabetCollectionViewCell* cell =
    (AlphabetCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:keyShowLetterSegue sender:cell];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 10;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    
    int numberOfCellInRowVertical = 8;

    CGFloat cellHeight =  [[UIScreen mainScreen] bounds].size.height/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}

@end
