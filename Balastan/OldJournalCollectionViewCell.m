//
//  OldJournalCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 13.06.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "OldJournalCollectionViewCell.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation OldJournalCollectionViewCell

- (OldJournalCollectionViewCell*) getournalCell:(MagazineItem*) page{
    self.imageCell.image = [UIImage imageWithData:[NSData dataWithContentsOfFile: [DOCUMENTS stringByAppendingPathComponent:page.imageFile ]]];
    return self;
}
@end
