//
//  LetterViewController.m
//  Balastan
//
//  Created by Avaz on 2/22/16.
//  Copyright © 2016 Balastan. All rights reserved.
//
#import "LetterViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LetterCollectionViewController.h"
#import "LetterItem.h"

static NSString* const kEmbedLetterCollection = @"EmbedLetterCollection";

@interface LetterViewController ()<AVAudioPlayerDelegate, LetterViewControllerDelegate>

@property (nonatomic, strong) LetterCollectionViewController* letterCollectionController;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property(strong, nonatomic) AVQueuePlayer * queuePlayer;

@end

@implementation LetterViewController

- (BOOL) shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self playAudioForIndex:self.letterIndex];
    
    self.nextButton.hidden = (self.letterIndex == self.letterArray.count - 1);
    
    self.previousButton.hidden = (self.letterIndex == 0);
    
    UITapGestureRecognizer* singleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(playAudioForIndex:)];
    singleTap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:singleTap];
}

-(void) letterCollectionController:(LetterCollectionViewController *)letterCollectionController
          didScrollToLetterAtIndex:(NSInteger)newLetterIndex{
    
    self.nextButton.hidden = (newLetterIndex == self.letterArray.count - 1);
    
    self.previousButton.hidden = (newLetterIndex == 0);
    
    self.letterIndex=newLetterIndex;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:kEmbedLetterCollection]) {
        
        self.letterCollectionController =
        segue.destinationViewController;
        
        self.letterCollectionController.delegate = self;
        self.letterCollectionController.letterArray = self.letterArray;
        self.letterCollectionController.letterIndex = self.letterIndex;
    }
}

- (void) playAudioForIndex:(NSInteger) index
{

    LetterItem* letter=self.letterArray[self.letterIndex];

    AVPlayerItem* letterAudioItem=[AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@", letter.audioLetter] withExtension:@"m4a"]];
    
    AVPlayerItem* letterWordItem=[AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@", letter.audioWord] withExtension:@"m4a"]];
    
    NSArray* queue=[NSArray arrayWithObjects:letterAudioItem, letterWordItem, nil];
    
    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:queue];
    self.queuePlayer.actionAtItemEnd = AVPlayerActionAtItemEndAdvance;
    [self.queuePlayer play];
}

- (IBAction)nextButton:(id)sender {
    
    self.letterIndex =[self.letterCollectionController showNextLetter];
    
    [self playAudioForIndex:self.letterIndex];
    
    self.nextButton.hidden = (self.letterIndex == self.letterArray.count - 1);
    
    self.previousButton.hidden = (self.letterIndex == 0);
}

- (IBAction)previousButton:(id)sender {
    
    self.letterIndex = [self.letterCollectionController showPreviousLetter];
        
    [self playAudioForIndex:self.letterIndex];
    
    self.nextButton.hidden = (self.letterIndex == self.letterArray.count - 1);
    
    self.previousButton.hidden = (self.letterIndex == 0);
}

@end
