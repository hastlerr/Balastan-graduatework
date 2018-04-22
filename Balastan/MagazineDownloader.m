//
//  MagazineDownloader.m
//  Balastan
//
//  Created by Avaz on 22.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MagazineDownloader.h"
#import <Quickblox/Quickblox.h>
#import "MagazineItem.h"
#import "TheMagazine.h"

static NSString* const keyJournalUD = @"journalUserDef";

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation MagazineDownloader


+ (NSOperationQueue*) izolationQueue
{
    static NSOperationQueue* __izolationQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        __izolationQueue = [NSOperationQueue new];
    });
    
    return __izolationQueue;
}




+ (void) downloadMagazineWithId:(NSInteger) magazineId
                     completion:(dispatch_block_t) completionBlock
                  progressBlock:(MagazineDownloaderProgressBlock) progressBlock
                     errorBlock:(MagazineDownloaderErrorBlock) errorBlock
{
    
        
        NSMutableDictionary* params = [NSMutableDictionary new];
        
        params[@"number"]   = [NSString stringWithFormat:@"%ld", (long)magazineId];
        params[@"sort_asc"] = @"page";
        
        [QBRequest objectsWithClassName:@"Number"
                        extendedRequest:params
                           successBlock:^(QBResponse* response, NSArray<QBCOCustomObject*>* objects, QBResponsePage* page)
         {
             [[self izolationQueue] addOperationWithBlock:^
              {
                  TheMagazine* magazineIssue = [TheMagazine new];
                  
                  magazineIssue.ID    = magazineId;
               //   magazineIssue.pages = [NSMutableArray new];// initWithCapacity:objects.count];
                  magazineIssue.parentID = objects[0].parentID;

                  [objects enumerateObjectsUsingBlock:^(QBCOCustomObject* obj,
                                                        NSUInteger idx,
                                                        BOOL* stop)
                   {
                       MagazineItem* item =
                       [[MagazineItem alloc] initWithDictionary:obj.fields
                                                          error:nil];
                       
                       item.ID = obj.ID;
                       
                       [magazineIssue.pages addObject:item];
                   }];
                  
                  
                  [self downloadDataForPagesInMagazine:magazineIssue
                                        magazineNumber:magazineId
                                            completion:completionBlock
                                         progressBlock:progressBlock
                                            errorBlock:errorBlock];
                  
                  
              }];
         }
                             errorBlock:^(QBResponse* response)
         {
             // Please, fail gracefully here
             NSLog(@"Failed to get pages!");
             NSLog(@"%@", response.error.error);
             
             if (errorBlock)
             {
                 errorBlock(@[response.error.error]);
             }
         }];
}
   


+ (void) downloadDataForPagesInMagazine:(TheMagazine*) magazine
                         magazineNumber:(NSInteger) magazineID
                             completion:(dispatch_block_t) completionBlock
                          progressBlock:(MagazineDownloaderProgressBlock) progressBlock
                             errorBlock:(MagazineDownloaderErrorBlock) errorBlock
{
    
      //directory operation
    NSString *folderName = [NSString stringWithFormat:@"Magazine_%ld", (long)magazine.ID];
    NSString *folderForMagazine = [DOCUMENTS stringByAppendingPathComponent: folderName];
    
    __block NSInteger progress = 0;
    __block NSInteger itemCount = magazine.pages.count*2;

    NSMutableArray* errors = [NSMutableArray new];
    
    dispatch_group_t download_group = dispatch_group_create();
    
    dispatch_group_enter(download_group);
    
    [magazine.pages enumerateObjectsUsingBlock:^(MagazineItem* page,
                                                 NSUInteger idx,
                                                 BOOL* stop)
     {
         // Download data for each page
         if (page.image && !page.imageFile)
         {
             dispatch_group_enter(download_group);
             [QBRequest downloadFileFromClassName:@"Number"
                                         objectID:page.ID
                                    fileFieldName:@"image"
                                     successBlock:^(QBResponse* response,
                                                    NSData* loadedData)
              {
                  [[self izolationQueue] addOperationWithBlock:^
                   {
                       NSString *imageName = [NSString stringWithFormat:@"image%ld.png", (long)idx];
                       
                       BOOL created =
                       [[NSFileManager defaultManager] createFileAtPath:[folderForMagazine stringByAppendingPathComponent:imageName]
                                                               contents:loadedData
                                                             attributes:nil];
                       
                       if (created)
                       {
                           page.imageFile = [folderName stringByAppendingPathComponent:imageName];
                           NSLog(@"File image%ld.png saved !", (long)idx);
                           ++progress;
                           
                           if (progressBlock)
                           {
                               progressBlock(progress, itemCount);
                           }
                       }
                       
                       dispatch_group_leave(download_group);
                   }];
              }
                                      statusBlock:NULL
                                       errorBlock:^(QBResponse* response)
              {
                  NSLog(@"File image%ld.png not downloaded ! T_T", (long)idx);
                  
                  [errors addObject:response.error.error];
                  
                  dispatch_group_leave(download_group);
              }];
         }else{
             --itemCount;
         }
         
         if (page.audio && !page.audioFile)
         {
             dispatch_group_enter(download_group);
             [QBRequest downloadFileFromClassName:@"Number"
                                         objectID:page.ID
                                    fileFieldName:@"audio"
                                     successBlock:^(QBResponse* response,
                                                    NSData* loadedData)
              {
                  [[self izolationQueue] addOperationWithBlock:^
                   {
                       NSString *audioName = [NSString stringWithFormat:@"audio%ld.m4a", (long)idx];
                       
                       BOOL created =
                       [[NSFileManager defaultManager] createFileAtPath:[folderForMagazine stringByAppendingPathComponent:audioName]
                                                               contents:loadedData
                                                             attributes:nil];
                       
                       if (created)
                       {
                           page.audioFile = [folderName stringByAppendingPathComponent:audioName];
                           NSLog(@"File audio%ld.m4a saved !", (long)idx);
                           ++progress;
                           
                           if (progressBlock)
                           {
                               progressBlock(progress, itemCount);
                           }
                       }
                       
                       dispatch_group_leave(download_group);
                   }];
              }
                                      statusBlock:NULL
                                       errorBlock:^(QBResponse* response)
              {
                  NSLog(@"File audio%ld.m4a not downloaded ! T_T", (long)idx);
                  
                  [errors addObject:response.error.error];
                  
                  dispatch_group_leave(download_group);
              }];
         }else{
             --itemCount;
         }
     }];
    
    dispatch_group_leave(download_group);
    
    dispatch_group_wait (download_group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"All requeste ended!");
    
    
    // Save the magazine here!
    
    if (errors.count == 0)
    {
        magazine.dowloadedStatus = YES;
        [self saveJournal:magazine numberJournal:magazineID];
        if(completionBlock){
            completionBlock();
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];

    }
    else
    {
        magazine.dowloadedStatus = NO;
        if (errorBlock)
        {
            errorBlock(errors);
        }
    }
    
}

+ (void) saveJournal:(TheMagazine *)magazine
       numberJournal:(NSInteger) number

{

    NSMutableDictionary *savedJournal = [NSMutableDictionary new];
    if ([self loadJournal]){
        savedJournal = [self loadJournal];
    }
    [savedJournal setObject:magazine forKey:[@(number) stringValue]];
    
    NSData* journalData = [NSKeyedArchiver archivedDataWithRootObject:savedJournal];
    
    [[NSUserDefaults standardUserDefaults] setObject:journalData
                                              forKey:keyJournalUD];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableDictionary*) loadJournal
{
    NSData* journalData =
    [[NSUserDefaults standardUserDefaults] objectForKey:keyJournalUD];
    
    NSMutableDictionary* journal = nil;
    
    if (journalData)
    {
        journal =
        [NSKeyedUnarchiver unarchiveObjectWithData:journalData];
    }
    
    return journal;
}


@end
