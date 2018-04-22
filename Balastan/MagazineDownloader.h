//
//  MagazineDownloader.h
//  Balastan
//
//  Created by Avaz on 22.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MagazineDownloaderProgressBlock)(NSInteger downloadedItems, NSInteger itemCount);

typedef void(^MagazineDownloaderErrorBlock)(NSArray<NSError*>* errors);

@interface MagazineDownloader : NSObject

+ (void) downloadMagazineWithId:(NSInteger) magazineId
                     completion:(dispatch_block_t) completionBlock
                  progressBlock:(MagazineDownloaderProgressBlock) progressBlock
                     errorBlock:(MagazineDownloaderErrorBlock) errorBlock;

@end
