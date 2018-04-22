//
//  PictureCollectionViewCell.h
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureItem.h"

@interface PictureCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) PictureItem* picture;
@property (strong, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (strong, nonatomic) IBOutlet UILabel  *pictureWord;


@end
