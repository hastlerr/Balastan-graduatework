//
//  MainMagazineCollectionViewController.m
//  Balastan
//
//  Created by Avaz on 15.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MainMagazineCollectionViewController.h"
#import "MainMajazineCollectionViewCell.h"
#import <Quickblox/Quickblox.h>
#import "MagazineItem.h"
#import "MagazineCover.h"
#import "JournalViewController.h"
#import "TheMagazine.h"
#import <KVNProgress/KVNProgress.h>
#import "MagazineDownloader.h"
#import "Reachability.h"
#import "OldJournalCollectionViewController.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface MainMagazineCollectionViewController (){
    
    NSMutableArray <MagazineCover*>* coverItem;
    NSMutableArray <TheMagazine*>* savedJournals;
    
}
@property (nonatomic, strong) MagazineCover *coverObject;
@property (nonatomic, strong) NSMutableArray<MagazineCover*>* savedCover;

@property (nonatomic, strong) NSOperationQueue* isolationQueue;

@end

@implementation MainMagazineCollectionViewController

static NSString* const reuseIdentifier         = @"Cell";
static NSString* const keyShowMagazineSegue    = @"ShowMagazineSegue";
static NSString* const keyShowOldMagazineSegue = @"showOldMagazine";
static NSString* const keyCoverUD              = @"coverUserDef";
static NSString* const keyJournalUD            = @"journalUserDef";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isolationQueue = [NSOperationQueue new];
    
    [self updateDataSource];
    [self requestForNewMagazine];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadJournal:)
                                                 name:@"downloadProgress"
                                               object:nil];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsCompact];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.tintColor =
    [UIColor colorWithRed:22.0/255.0 green:123.0/255.0 blue:33.0/255.0 alpha:1.0];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
    

}

- (void) updateDataSource{
    coverItem     = [NSMutableArray new];
    savedJournals = [NSMutableArray new];

    NSMutableDictionary *savedCoverDic   = [self loadJournalCoverWhithKey: keyCoverUD];
    @try{
    for (int i=0; i < savedCoverDic.count; i++){
        [coverItem addObject:[savedCoverDic valueForKey:[@(i+1) stringValue]]];
    }
    
    NSMutableDictionary *savedJournalDic = [self loadJournalCoverWhithKey: keyJournalUD];
    int j = (int)savedJournalDic.count;
    for (int i=0; i < j; i++){
        TheMagazine *journal = [savedJournalDic objectForKey:[@(i+1) stringValue]];
        if (journal){
            [savedJournals addObject:journal];
        } else {
            [savedJournals addObject:[NSNull null]];
            j++;
        }
    }
    }
    @catch (NSException *exception){
        
    }
}


- (void) requestForNewMagazine{
    __block NSMutableArray *coverID = [NSMutableArray new];

    [ QBRequest objectsWithClassName:@"Magazine" successBlock:^(QBResponse *  response, NSArray *  objects) {
        coverID = [objects valueForKey:@"ID"];
        [self downloadCover: coverID];
    } errorBlock:^(QBResponse *  response) {
        NSLog (@"Response error: %@", [response.error description]);
    }];
    
}





-(void) downloadCover:(NSMutableArray*) coverID{
    
    [self.isolationQueue addOperationWithBlock:^
     {
         __block int q = (int)coverItem.count;
         dispatch_group_t download_group = dispatch_group_create();
         
         dispatch_group_enter(download_group);

         for(int i = (int)coverItem.count; i<coverID.count; i++){
             
             dispatch_group_enter(download_group);
             
             MagazineCover *cover = [MagazineCover new];
             
             NSString *folderName = [NSString stringWithFormat:@"Magazine_%d", i+1];
             NSString *folderForMagazine = [DOCUMENTS stringByAppendingPathComponent: folderName];
             [[NSFileManager defaultManager] createDirectoryAtPath:folderForMagazine
                                       withIntermediateDirectories:YES attributes:nil
                                                             error: nil];
             NSString *ID =[coverID objectAtIndex:i];
             [QBRequest downloadFileFromClassName:@"Magazine" objectID:ID
                                    fileFieldName:@"MagazineCover"
                                     successBlock:^(QBResponse *  response, NSData *  loadedData) {
                                         int w = i;
                                         NSString *fileName = [NSString stringWithFormat:@"cover%d.png",i];
                                         NSString *imageDir = [folderForMagazine stringByAppendingPathComponent:fileName];
                                         
                                         BOOL created =[[NSFileManager defaultManager] createFileAtPath:imageDir
                                                                                               contents:loadedData
                                                                                             attributes:nil];
                                         
                                         if (created){
                                             
                                             cover.coverImage = [folderName stringByAppendingPathComponent:fileName];
                                             cover.coverDownloadStatus = YES;
                                             NSMutableDictionary *coverDictionary = [NSMutableDictionary new];
                                             if ([self loadJournalCoverWhithKey:keyCoverUD]){
                                                 coverDictionary = [self loadJournalCoverWhithKey:keyCoverUD];
                                             }
                                             [coverDictionary setObject:cover forKey:[@(i+1) stringValue]];
                                             [self saveJournalItems:coverDictionary dataKey:keyCoverUD];
                                             if (q == w){
                                                 q++;
                                                 [self updateDataSource];
                                                 
                                                 
                                                 dispatch_group_leave(download_group);
                                                 
                                                 
                                             }
                                             
                                         } else {
                                             cover.coverDownloadStatus = NO;
                                             NSLog(@"File not saved T_T");
                                             
                                             
                                             dispatch_group_leave(download_group);
                                             
                                         }
                                         [self.collectionView reloadData];
                                         
                                     } statusBlock:^(QBRequest *  request, QBRequestStatus * _Nullable status) {
                                         NSLog(@"progress for cover %f", status.percentOfCompletion);
                                     } errorBlock:^(QBResponse *  response) {
                                         
                                         dispatch_group_leave(download_group);
                                         
                                     }];
             
             
         }
         
         dispatch_group_leave(download_group);
         dispatch_group_wait (download_group, DISPATCH_TIME_FOREVER);
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - NSUserDefaults storage

- (NSMutableDictionary*) loadJournalCoverWhithKey:(NSString*) keyData
{
    NSData* journalData =
    [[NSUserDefaults standardUserDefaults] objectForKey:keyData];
    
    NSMutableDictionary* journalCover = nil;
    
    if (journalData)
    {
        journalCover =
        [NSKeyedUnarchiver unarchiveObjectWithData:journalData];
    }
    
    return journalCover;
}



- (void) saveJournalItems:(NSMutableDictionary *)journalToSave
                  dataKey:(NSString*) dataKey
{
    NSData* journalData =
    [NSKeyedArchiver archivedDataWithRootObject:journalToSave];
    
    [[NSUserDefaults standardUserDefaults] setObject:journalData
                                              forKey:dataKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) downloadJournal:(NSNotification*) notification {
    Reachability* rech = [ Reachability new];
    if (![rech connected]) {
        [KVNProgress showErrorWithStatus:@"ИНТЕРНЕТ ЖОК"];
    }
    else
    {
        // Connected. Do some Internet stuff
        [KVNProgress showProgress:0
                           status:@"Көчүрүү"];
        
        UIButton* sender = notification.object;
        [MagazineDownloader downloadMagazineWithId:sender.tag
                                        completion:^{
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [KVNProgress showSuccess];
                                                [KVNProgress dismiss];
                                                [self updateDataSource];
                                                [self.collectionView reloadData];
                                            });
                                        }
                                     progressBlock:^(NSInteger downloadedItems, NSInteger itemsCount) {
                                         
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             NSString* procent =
                                             [NSString stringWithFormat:@"%0.0f %@", downloadedItems/(float)itemsCount*100,@"%"];
                                             [KVNProgress showProgress:downloadedItems/(float)itemsCount
                                                                status:procent];
                                         });
                                     }
                                        errorBlock:^(NSArray<NSError *> *errors) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [KVNProgress showError];
                                                [KVNProgress dismiss];
                                            });
                                        }];
        
    }
}

#pragma mark - Navigation

- (void) collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(savedJournals){
        if(savedJournals.count > indexPath.row){
            if ([savedJournals[indexPath.row] isKindOfClass:[TheMagazine class]]) {
                if(savedJournals[indexPath.row].dowloadedStatus){
                    if(savedJournals[indexPath.row].dowloadedStatus == YES){
                        UICollectionViewCell* cell =
                        [self.collectionView cellForItemAtIndexPath:indexPath];
                        if (savedJournals[indexPath.row].parentID){
                            [self performSegueWithIdentifier:keyShowOldMagazineSegue
                                                      sender:cell];
                        } else {
                            [self performSegueWithIdentifier:keyShowMagazineSegue
                                                      sender:cell];
                        }
                    }
                }
            }
        }
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];
    
    if ([segue.identifier isEqualToString:keyShowMagazineSegue])
    {
        
        UICollectionViewCell* cell = (UICollectionViewCell*)sender;
        NSIndexPath* idxPath = [self.collectionView indexPathForCell:cell];
        JournalViewController* magazineController = segue.destinationViewController;
        magazineController.journal = [savedJournals objectAtIndex:idxPath.row];
        
    }
    if ([segue.identifier isEqualToString:keyShowOldMagazineSegue])
    {
        UICollectionViewCell* cell = (UICollectionViewCell*)sender;
        NSIndexPath* idxPath = [self.collectionView indexPathForCell:cell];
        OldJournalCollectionViewController* oldMagazineController = segue.destinationViewController;
        oldMagazineController.journal = [savedJournals objectAtIndex:idxPath.row];
        
    }
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return coverItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainMajazineCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MagazineCover *obj = [coverItem objectAtIndex: indexPath.row];
    cell.magazineImageView.layer.masksToBounds = YES;
    if(savedJournals.count>indexPath.row && [savedJournals[indexPath.row] isKindOfClass:[TheMagazine class]]){
    cell.downloadButtonOutlet.hidden = savedJournals[indexPath.row].dowloadedStatus;
    }
    cell.downloadButtonOutlet.layer.cornerRadius = 10;
    cell.magazineImageView.layer.cornerRadius    = 10;
    cell.magazineImageView.image =
    [UIImage imageWithData:[NSData dataWithContentsOfFile: [DOCUMENTS stringByAppendingPathComponent:obj.coverImage ]]];
    [cell.downloadButtonOutlet setTag:indexPath.row+1];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    
    int numberOfCellInRowVertical = 1;
    
    CGFloat cellHeight =  [[UIScreen mainScreen] bounds].size.height/numberOfCellInRowVertical;
    
    return CGSizeMake(cellWidth, cellHeight);
}
- (void) reloadData{
    [self.collectionView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
