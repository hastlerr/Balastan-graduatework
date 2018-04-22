//
//  SlideMenuCollectionViewController.h
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureItem.h"

@interface SlideMenuCollectionViewController : UICollectionViewController
@property(assign, nonatomic) NSInteger tag;
@property(strong, nonatomic) NSArray <PictureItem*>* pictureArray;
@end
