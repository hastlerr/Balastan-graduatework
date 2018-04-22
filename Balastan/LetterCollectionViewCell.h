//
//  LetterCollectionViewCell.h
//  Balastan
//
//  Created by Avaz on 2/24/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LetterItem.h"

@interface LetterCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) LetterItem* letter;
@property (strong, nonatomic) IBOutlet UIImageView *letterImageView;
@property (strong, nonatomic) IBOutlet UIImageView *letterWordImageView;
@property (strong, nonatomic) IBOutlet UIImageView *letterExampleImageView;


@end
