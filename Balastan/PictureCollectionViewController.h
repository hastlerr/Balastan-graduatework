//
//  PictureCollectionViewController.h
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureItem.h"
#import "PictureViewController.h"

@class PictureCollectionViewController;

@protocol PictureViewControllerDelegate <NSObject>

- (void) pictureCollectionController:(PictureCollectionViewController*) pictureCollectionController
            didScrollToLetterAtIndex:(NSInteger) newPictureIndex;

- (void) playAudioForIndex:(NSInteger) index;

@end

@interface PictureCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<PictureViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray<PictureItem*> * pictureArray;
@property (assign, nonatomic) NSInteger pictureIndex;

- (NSInteger) showNextPicture;
- (NSInteger) showPreviousPicture;

@end
