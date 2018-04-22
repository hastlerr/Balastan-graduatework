//
//  AlphabetMenuViewController.m
//  Balastan
//
//  Created by Avaz on 2/20/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "AlphabetMenuViewController.h"
#import "AlphabetCollectionViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSString* const keyShowAlphabetSegue      =  @"showAlphabetSegue";
static NSString* const keyShowAlphabetTestSegue  =  @"showAlphabetTestSegue";


@interface AlphabetMenuViewController ()<AVAudioPlayerDelegate>
@property(strong, nonatomic) AVAudioPlayer* player;
@end

@implementation AlphabetMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL* url=[[NSBundle mainBundle] URLForResource:@"aripter" withExtension:@".m4a"];
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player setDelegate:self];
    [self.player play];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)showAlphabetCollectionButton:(id)sender {
    
    [self performSegueWithIdentifier:keyShowAlphabetSegue sender:nil];
    
}

- (IBAction)showAlphabetTestButton:(id)sender {
    if([self.player isPlaying])[self.player stop];
    [ self performSegueWithIdentifier:keyShowAlphabetTestSegue sender:nil];
}


@end
