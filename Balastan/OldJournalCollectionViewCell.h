//
//  OldJournalCollectionViewCell.h
//  Balastan
//
//  Created by Avaz on 13.06.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineItem.h"


@interface OldJournalCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageCell;
- (OldJournalCollectionViewCell*) getournalCell:(MagazineItem*) page;
@end
