//
//  MagazineCover.h
//  Balastan
//
//  Created by Avaz on 29.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazineCover : NSObject<NSCoding>

@property(strong, nonatomic) NSString* coverImage;
@property(assign, nonatomic) BOOL coverDownloadStatus;

@end
