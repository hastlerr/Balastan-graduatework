//
//  TheMagazine.h
//  Balastan
//
//  Created by Avaz on 14.05.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MagazineItem.h"

@interface TheMagazine : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *parentID;
@property (nonatomic, strong) NSMutableArray<MagazineItem*>* pages;
@property (nonatomic, assign) BOOL dowloadedStatus;

@end
