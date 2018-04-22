//
//  AlpabetTestViewController.m
//  Balastan
//
//  Created by Avaz on 25.02.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "AlpabetTestViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LetterTestItem.h"

@interface AlpabetTestViewController ()<AVAudioPlayerDelegate>

@property(strong, nonatomic) NSArray <LetterTestItem*>* letterTestArray;
@property (weak, nonatomic) IBOutlet UIButton *AlphabetTestNumberOneOutlet;
@property (weak, nonatomic) IBOutlet UIButton *AlphabetTestNumberTwoOutlet;
@property (weak, nonatomic) IBOutlet UIButton *AlphabetTestNumberThreeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *AlphabetTestNumberFourOutlet;
@property (weak, nonatomic) IBOutlet UIView *animateView;
@property (strong, nonatomic) NSArray <LetterTestItem*>* objectArray;
@property(strong, nonatomic) AVAudioPlayer* player;

@end

@implementation AlpabetTestViewController

   NSInteger i;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.AlphabetTestNumberOneOutlet.layer.cornerRadius   = 10;
    self.AlphabetTestNumberTwoOutlet.layer.cornerRadius   = 10;
    self.AlphabetTestNumberThreeOutlet.layer.cornerRadius = 10;
    self.AlphabetTestNumberFourOutlet.layer.cornerRadius  = 10;

    NSString* lettersPath =
    [[NSBundle mainBundle] pathForResource:@"LettersTest" ofType:@"json"];
    
    NSData* lettersData =
    [NSData dataWithContentsOfFile:lettersPath];
    
    NSError* jsonError = nil;
    
    self.letterTestArray =
    [LetterTestItem arrayOfModelsFromData:lettersData
                                error:&jsonError];

    [self nextLevel];

}

- (IBAction)AlphabetTestButton:(id)sender {
    
    LetterTestItem *obj = [[LetterTestItem alloc] init];
    obj = [self.letterTestArray objectAtIndex:i];

    if (i == [sender tag]){
        
        [self playAudioTrack:@"tuura"];
        i == 35 ? i=0 :i++;
        
        CGAffineTransform initialTransform = self.animateView.transform;
        CGAffineTransform scaledTransform = CGAffineTransformScale(initialTransform, 0.8f, 0.8f);
        
        [UIView animateWithDuration:1
                         animations:^{
                             self.animateView.transform = scaledTransform;
                             self.animateView.alpha = 0.8f;
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:1
                                              animations:^{
                                                  self.animateView.transform = initialTransform;
                                                  self.animateView.alpha = 1.0f;
                                              }
                                              completion:^(BOOL finished) {
                                                  [self nextLevel];
                                              }];
                             
                         }];
    } else {
        
        [self playAudioTrack:@"tuuraemes"];
    }
    
}

- (void) nextLevel{
    
    int randomNumber[4];
    for (int p=0; p<4;p++) {
        randomNumber[p] = arc4random_uniform(36);
        if(p!=0){
            for (int j=0; j<p; j++) {
                if (randomNumber[j] == randomNumber[p]) {
                    randomNumber[p] = arc4random_uniform(36);
                }
            }
        }
    }
    
    LetterTestItem *objectNumberOne   = [self.letterTestArray objectAtIndex:randomNumber[0]];
    LetterTestItem *objectNumberTwo   = [self.letterTestArray objectAtIndex:randomNumber[1]];
    LetterTestItem *objectNumberThree = [self.letterTestArray objectAtIndex:randomNumber[2]];
    LetterTestItem *objectNumberFour  = [self.letterTestArray objectAtIndex:randomNumber[3]];
    
    self.objectArray = [ NSArray arrayWithObjects:objectNumberOne,
                        objectNumberTwo,
                        objectNumberThree,
                        objectNumberFour,
                        nil];
    i = arc4random_uniform(4);
    
    LetterTestItem  *randomObject = [self.objectArray objectAtIndex:i];
    
    [self playAudioTrack : randomObject.audioLetter ];
    
    
    
    LetterTestItem  *Object = [self.objectArray objectAtIndex:0];
    
    [self.AlphabetTestNumberOneOutlet setImage:[UIImage imageNamed:Object.letterImage]
                                forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:1];
    [self.AlphabetTestNumberTwoOutlet setImage:[UIImage imageNamed:Object.letterImage]
                                forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:2];
    [self.AlphabetTestNumberThreeOutlet setImage:[UIImage imageNamed:Object.letterImage]
                                  forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:3];
    [self.AlphabetTestNumberFourOutlet setImage:[UIImage imageNamed:Object.letterImage]
                                 forState:UIControlStateNormal];
    
}

- (void) playAudioTrack:(NSString*) audioTrack{
    
    [super viewDidLoad];
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/%@.m4a", [[NSBundle mainBundle] resourcePath], audioTrack];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

@end
