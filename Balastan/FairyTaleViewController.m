//
//  FairyTaleViewController.m
//  Balastan
//
//  Created by Avaz on 2/27/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "FairyTaleViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FairyTaleItem.h"

@interface FairyTaleViewController ()<AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *fairyTaleCurrentImage;
@property(strong, nonatomic) AVAudioPlayer* player;
@property(strong, nonatomic) NSTimer* timer;
@property(assign, nonatomic) NSInteger slideIndex;
@property (strong, nonatomic) IBOutlet UIImageView *pauseImageView;
@end


@implementation FairyTaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.slideIndex=0;
    
    self.pauseImageView.hidden=YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UITapGestureRecognizer* singleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(fairyTalePlayPauseTap)];
    singleTap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:singleTap];
    
    self.fairyTaleCurrentImage.userInteractionEnabled = YES;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self playAudio];
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                              selector:@selector(updateFairyTaleCurrentImage)
                                                       userInfo:nil
                                                        repeats:YES];
    
    self.fairyTaleCurrentImage.image=[UIImage imageNamed:[self.fairyTale fairyTaleNameImage]];
}

- (void) updateFairyTaleCurrentImage
{

    if (self.slideIndex < self.fairyTale.slides.count)
    {
        FairyTaleSlide* slide = self.fairyTale.slides[self.slideIndex];
        NSTimeInterval time= slide.time;
        
        if([self.player currentTime]>=time){
            self.fairyTaleCurrentImage.image=[UIImage imageNamed:slide.fairyTaleCurrentImage];
            self.slideIndex+=1;
        }
    }
}

-(void) playAudio{
    
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:self.fairyTale.audioFairyTale withExtension:@".m4a"];
    
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player setDelegate:self];
    [self.player play];
}

-(void)fairyTalePlayPauseTap{
    if([self.player isPlaying]==YES)
    {
        [self.player pause];
        self.pauseImageView.hidden=NO;
        [self.timer invalidate];
    
        [UIView animateKeyframesWithDuration:3.0 delay:0.0
                                     options:UIViewKeyframeAnimationOptionCalculationModePaced | UIViewAnimationOptionCurveEaseInOut | UIViewKeyframeAnimationOptionRepeat
                                  animations:^{
                                      [self.pauseImageView setAlpha:1.f];
                                      [self.pauseImageView setAlpha:0.f];                                  }
                                  completion:nil];
    
    }
    else
    {
        [self.player play];
        self.pauseImageView.hidden=YES;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(updateFairyTaleCurrentImage)
                                                  userInfo:nil
                                                   repeats:YES];
    }
    
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.fairyTaleCurrentImage.image=[UIImage imageNamed:@"ayagy"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
}

@end
