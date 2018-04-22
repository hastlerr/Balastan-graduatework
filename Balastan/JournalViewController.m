//
//  JournalViewController.m
//  Balastan
//
//  Created by Avaz on 26.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "JournalViewController.h"
#import "PagesCollectionViewController.h"
#import "MainPageCollectionViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MagazineItem.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

static NSString* const kPagesCollection    = @"pagesSegue";
static NSString* const kMainPageCollection = @"mainPageSegue";
static NSString* const kTextView           = @"textsegue";

@interface JournalViewController ()<AVAudioPlayerDelegate>
- (IBAction)playButtonAction:(id)sender;
- (IBAction)pagesConteinerButton:(id)sender;
- (IBAction)backButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *pagesContainerOutlet;
@property (strong, nonatomic) IBOutlet UIButton *pagesContainerOpenOutlet;
@property (strong, nonatomic) IBOutlet UIButton* pagesContainerCloseOutlet;
@property (strong, nonatomic) IBOutlet UIButton *playButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *backButtonOutlet;

@property(strong, nonatomic) AVAudioPlayer* player;

@property (nonatomic, strong) PagesCollectionViewController* pagesController;
@property (nonatomic, strong) MainPageCollectionViewController* mainPageController;
@property (nonatomic, strong) MagazineItem* page;

@end

@implementation JournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.pagesContainerOpenOutlet.layer.cornerRadius = 10;
    self.pagesContainerCloseOutlet.layer.cornerRadius = 10;
    self.playButtonOutlet.layer.cornerRadius = 10;
    self.backButtonOutlet.layer.cornerRadius = 10;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playAudio:)
                                                 name:@"playAudioNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hiddenPagesContainer)
                                                 name:@"hiddenPagesContainer"
                                               object:nil];
    
    
    
}


- (void)playAudio:(NSNotification*)notification {
    [self playAudioByNumber:[notification.object row]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:kPagesCollection]) {
        
        self.pagesController =
        segue.destinationViewController;
        self.pagesController.pagesArray = _journal.pages;
    }
    else if ([segue.identifier isEqualToString:kMainPageCollection]) {
        
        self.mainPageController =
        segue.destinationViewController;
        self.mainPageController.pagesArray = _journal.pages;
    }
    
    
    
}

-(void) playAudioByNumber:(NSInteger)pageNumber{
    
    self.page = [_journal.pages objectAtIndex:pageNumber];
    
    if (_page.audioFile) {
        NSData *audioData =[NSData dataWithContentsOfFile:[DOCUMENTS stringByAppendingPathComponent:_page.audioFile ]];
        
        self.player=[[AVAudioPlayer alloc] initWithData:audioData error:nil];
        [self.player play];
        [self.playButtonOutlet setImage:[UIImage imageNamed:@"volume_off"]
                               forState:UIControlStateNormal];

    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (IBAction)playButtonAction:(id)sender {
    if([self.player isPlaying]==YES)
    {
        [self.player pause];
        [self.playButtonOutlet setImage:[UIImage imageNamed:@"volume_on"]
                               forState:UIControlStateNormal];
        
    } else {
        [self.player play];
        [self.playButtonOutlet setImage:[UIImage imageNamed:@"volume_off"]
                               forState:UIControlStateNormal];
    }
}

- (IBAction)pagesConteinerButton:(id)sender {
    
    if(self.pagesContainerOutlet.layer.hidden == YES){
        self.pagesContainerOutlet.layer.hidden = NO;
        self.pagesContainerCloseOutlet.layer.hidden = NO;
        self.pagesContainerOpenOutlet.layer.hidden = YES;
        
    } else {
        self.pagesContainerOutlet.layer.hidden = YES;
        self.pagesContainerCloseOutlet.layer.hidden = YES;
        self.pagesContainerOpenOutlet.layer.hidden = NO;
    }
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) hiddenPagesContainer{
    self.pagesContainerOutlet.layer.hidden = YES;
    self.pagesContainerCloseOutlet.layer.hidden = YES;
    self.pagesContainerOpenOutlet.layer.hidden = NO;
}

@end
