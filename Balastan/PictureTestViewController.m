//
//  PictureTestViewController.m
//  Balastan
//
//  Created by Avaz on 03.03.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PictureTestViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PicturesTestItem.h"

NSInteger j;

@interface PictureTestViewController ()

@property (strong, nonatomic) NSArray<PicturesTestItem*>* picturesItemArray;
@property (strong, nonatomic) NSArray <PicturesTestItem*>* objectArray;
@property (strong, nonatomic) AVAudioPlayer* player;
@property (weak, nonatomic) IBOutlet UIButton *pictiresTestOneOutlet;
@property (weak, nonatomic) IBOutlet UIButton *picturesTestTwoOutlet;
@property (weak, nonatomic) IBOutlet UIButton *picturesTestThreeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *picturesTestFourOutlet;
@property (weak, nonatomic) IBOutlet UIView *animateView;

@end

@implementation PictureTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pictiresTestOneOutlet.layer.cornerRadius   = 10;
    self.picturesTestTwoOutlet.layer.cornerRadius   = 10;
    self.picturesTestThreeOutlet.layer.cornerRadius = 10;
    self.picturesTestFourOutlet.layer.cornerRadius  = 10;
    
    NSString* animalPath =
    [[NSBundle mainBundle] pathForResource:@"AnimalsTest" ofType:@"json"];
    
    NSData* animalData =
    [NSData dataWithContentsOfFile:animalPath];
    
    NSError* jsonError = nil;
    
    self.picturesItemArray =
    [PicturesTestItem arrayOfModelsFromData:animalData
                                     error:&jsonError];

    [self nextLevel];
    
}
- (IBAction)picturesTestActionButton:(id)sender {
    
   // PicturesTestItem *obj = [self.objectArray objectAtIndex:i];
    if(j == [sender tag]){
        
        [self playAudioTrack:@"tuura"];
        
        CGAffineTransform initialTransform = self.animateView.transform;
        CGAffineTransform scaledTransform = CGAffineTransformScale(initialTransform, 0.8f, 0.8f);
        
        [UIView animateWithDuration:1
                              delay:0
                            options:0//UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.animateView.transform = scaledTransform;
                             self.animateView.alpha = 0.8f;
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:1
                                                   delay:0
                                                 options:0//UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
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
        randomNumber[p] = arc4random_uniform(67);
        if(p!=0){
            for (int j=0; j<p; j++) {
                if (randomNumber[j] == randomNumber[p]) {
                    randomNumber[p] = arc4random_uniform(67);
                }
            }
        }
    }
    
    PicturesTestItem *objectNumberOne   = [self.picturesItemArray objectAtIndex:randomNumber[0]];
    PicturesTestItem *objectNumberTwo   = [self.picturesItemArray objectAtIndex:randomNumber[1]];
    PicturesTestItem *objectNumberThree = [self.picturesItemArray objectAtIndex:randomNumber[2]];
    PicturesTestItem *objectNumberFour  = [self.picturesItemArray objectAtIndex:randomNumber[3]];
    
    self.objectArray = [ NSArray arrayWithObjects:objectNumberOne,
                        objectNumberTwo,
                        objectNumberThree,
                        objectNumberFour,
                        nil];
    j = arc4random_uniform(4);
    
    PicturesTestItem  *randomObject = [self.objectArray objectAtIndex:j];
    
    [self playAudioTrack : randomObject.animalImage ];
    
    
    
    PicturesTestItem  *Object = [self.objectArray objectAtIndex:0];

    [self.pictiresTestOneOutlet setImage:[UIImage imageNamed:Object.animalAudio]
                                      forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:1];
    [self.picturesTestTwoOutlet setImage:[UIImage imageNamed:Object.animalAudio]
                                      forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:2];
    [self.picturesTestThreeOutlet setImage:[UIImage imageNamed:Object.animalAudio]
                                        forState:UIControlStateNormal];
    
    Object = [self.objectArray objectAtIndex:3];
    [self.picturesTestFourOutlet setImage:[UIImage imageNamed:Object.animalAudio]
                                       forState:UIControlStateNormal];
}


- (void) playAudioTrack:(NSString*) audioTrack{
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/%@.m4a", [[NSBundle mainBundle] resourcePath], audioTrack];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    [self.player play];
}

@end
