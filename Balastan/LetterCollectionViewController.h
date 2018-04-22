//
//  LetterCollectionViewController.h
//  Balastan
//
//  Created by Avaz on 2/24/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LetterViewController.h"
#import "LetterItem.h"

@class LetterCollectionViewController;

@protocol LetterViewControllerDelegate <NSObject>

- (void) letterCollectionController:(LetterCollectionViewController*) letterCollectionController
           didScrollToLetterAtIndex:(NSInteger) newLetterIndex;

- (void) playAudioForIndex:(NSInteger) index;

@end

@interface LetterCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<LetterViewControllerDelegate> delegate;
@property(strong, nonatomic) NSArray<LetterItem*> * letterArray;
@property(assign, nonatomic) NSInteger letterIndex;

- (NSInteger) showNextLetter;
- (NSInteger) showPreviousLetter;

@end

