//
//  PictureViewController.h
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureItem.h"

@interface PictureViewController : UIViewController

@property(strong, nonatomic) NSArray<PictureItem*> * pictureArray;
@property(assign, nonatomic) NSInteger pictureIndex;

- (IBAction)nextButton:(id)sender;
- (IBAction)previousButton:(id)sender;

@end
