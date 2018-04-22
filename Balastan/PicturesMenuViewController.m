//
//  PicturesMenuViewController.m
//  Balastan
//
//  Created by Avaz on 03.03.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PicturesMenuViewController.h"
#import "PictureItem.h"
#import "SlideMenuCollectionViewController.h"
#import <AVFoundation/AVFoundation.h>


static NSString* const keyShowPictureMenuSegue    =    @"showSlideMenuSegue";
static NSString* const keyShowTestlMenuSegue     =    @"showPictureTestSegue";

@interface PicturesMenuViewController ()

@property(strong, nonatomic) NSArray<PictureItem*> *pictureArray;
@property(strong, nonatomic) NSArray<PictureItem*> *fruitArray;
@property(strong, nonatomic) NSArray<PictureItem*> *animalArray;
@property(strong, nonatomic) NSArray<PictureItem*> *autoArray;
@property(assign, nonatomic) NSInteger tag;
@property(strong, nonatomic) AVAudioPlayer* player;

@end

@implementation PicturesMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:@"surot_soz" withExtension:@".m4a"];
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    
    NSData* fruitData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                       pathForResource:@"Fruits" ofType:@"json"]];
    
    self.fruitArray = [PictureItem arrayOfModelsFromData:fruitData
                                                   error:nil];
    
    NSData* animalData =
    [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"json"]];
    
    self.animalArray =
    [PictureItem arrayOfModelsFromData:animalData
                                 error:nil];
    
    NSData* autoData =
    [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Auto" ofType:@"json"]];
    
    self.autoArray =
    [PictureItem arrayOfModelsFromData:autoData
                                 error:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}


- (IBAction)pictureMenuActionButton:(id)sender {
    
    if([self.player isPlaying])[self.player stop];
    if([sender tag]==0)
        self.pictureArray=self.fruitArray;
    else if ([sender tag]==1)
        self.pictureArray=self.animalArray;
    else if ([sender tag]==2)
        self.pictureArray=self.autoArray;
    
    self.tag=[sender tag];
    
    [self performSegueWithIdentifier:keyShowPictureMenuSegue sender:self.pictureArray];
    
}

- (IBAction)pictureTestActionButton:(id)sender {

    if([self.player isPlaying])[self.player stop];

    [self performSegueWithIdentifier: keyShowTestlMenuSegue
                              sender:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];
    
    if([segue.identifier isEqualToString:keyShowPictureMenuSegue]){
        
        SlideMenuCollectionViewController* slideMenuController =
        segue.destinationViewController;
        
        slideMenuController.pictureArray = self.pictureArray;
        slideMenuController.tag=self.tag;
    }
}

@end
