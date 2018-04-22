//
//  PictureViewController.m
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PictureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PictureCollectionViewController.h"
#import "PictureItem.h"

static NSString* const kEmbedPictureCollection = @"EmbedPictureCollection";

@interface PictureViewController ()<AVAudioPlayerDelegate, PictureViewControllerDelegate>
@property (nonatomic, strong) PictureCollectionViewController* pictureCollectionController;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) AVAudioPlayer * player;

@end

@implementation PictureViewController

- (BOOL) shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self playAudioForIndex:self.pictureIndex];
    
    self.nextButton.hidden = (self.pictureIndex == self.pictureArray.count - 1);
    
    self.previousButton.hidden = (self.pictureIndex == 0);
    
    UITapGestureRecognizer* singleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(playAudioForIndex:)];
    singleTap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:singleTap];

}

-(void) pictureCollectionController:(PictureCollectionViewController *)pictureCollectionController
          didScrollToLetterAtIndex:(NSInteger)newPictureIndex{
    
    self.nextButton.hidden = (newPictureIndex == self.pictureArray.count - 1);
    
    self.previousButton.hidden = (newPictureIndex == 0);
    
    self.pictureIndex=newPictureIndex;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:kEmbedPictureCollection]) {
        
        self.pictureCollectionController =
        segue.destinationViewController;
        
        self.pictureCollectionController.delegate = self;
        self.pictureCollectionController.pictureArray = self.pictureArray;
        self.pictureCollectionController.pictureIndex = self.pictureIndex;
    }
}

- (void) playAudioForIndex:(NSInteger) index
{
    PictureItem* picture = self.pictureArray[self.pictureIndex];
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:[picture audioWord] withExtension:@".m4a"];
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player setDelegate:self];
    [self.player play];
}


- (IBAction)nextButton:(id)sender {
    
    self.pictureIndex =[self.pictureCollectionController showNextPicture];
    
    [self playAudioForIndex:self.pictureIndex];
    
    self.nextButton.hidden = (self.pictureIndex == self.pictureArray.count - 1);
    
    self.previousButton.hidden = (self.pictureIndex == 0);
}

- (IBAction)previousButton:(id)sender {
    
    self.pictureIndex = [self.pictureCollectionController showPreviousPicture];
    
    [self playAudioForIndex:self.pictureIndex];
    
    self.nextButton.hidden = (self.pictureIndex == self.pictureArray.count - 1);
    
    self.previousButton.hidden = (self.pictureIndex == 0);
}

@end
