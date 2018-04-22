//
//  FairyTalesMenuViewController.m
//  Balastan
//
//  Created by Avaz on 3/3/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "FairyTalesMenuViewController.h"
#import "FairyTaleViewController.h"
#import "FairyTaleItem.h"
#import <AVFoundation/AVFoundation.h>

static NSString* const keyShowFairyTaleSegue =  @"showFairyTaleSegue";

@interface FairyTalesMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *oneOutlet;
@property (weak, nonatomic) IBOutlet UIButton *twoOutlet;
@property (weak, nonatomic) IBOutlet UIButton *threeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *fourOutlet;

@property(strong, nonatomic) NSArray<FairyTaleItem*>* fairyTaleArray;
@property(assign,nonatomic) NSInteger fairyTaleIndex;
@property(strong, nonatomic) AVAudioPlayer* player;

-(IBAction)showFairyTale:(id)sender;

@end

@implementation FairyTalesMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oneOutlet.layer.cornerRadius   = 10;
    self.twoOutlet.layer.cornerRadius   = 10;
    self.threeOutlet.layer.cornerRadius = 10;
    self.fourOutlet.layer.cornerRadius  = 10;

    NSString* fairyTalesPath =
    [[NSBundle mainBundle] pathForResource:@"Fairytales" ofType:@"json"];
    
    NSData* fairyTalesData =
    [NSData dataWithContentsOfFile:fairyTalesPath];
    
    self.fairyTaleArray =
    [FairyTaleItem arrayOfModelsFromData:fairyTalesData
                                error:nil];
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:@"j_kyrgyz_el_jomok" withExtension:@".m4a"];
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(IBAction)showFairyTale:(id)sender{
    
    self.fairyTaleIndex=[sender tag];
    
    FairyTaleItem* fairyTale=self.fairyTaleArray[self.fairyTaleIndex];
    
    [self performSegueWithIdentifier:keyShowFairyTaleSegue sender:fairyTale];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue
                    sender:sender];

    if([segue.identifier isEqualToString:keyShowFairyTaleSegue]){
        
    FairyTaleViewController* fairyTaleController =
    segue.destinationViewController;
    
    fairyTaleController.fairyTale = self.fairyTaleArray[self.fairyTaleIndex];
    }
}

@end
