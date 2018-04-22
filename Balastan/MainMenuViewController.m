//
//  ViewController.m
//  Balastan
//
//  Created by Avaz on 2/19/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AlphabetMenuViewController.h"
#import "FairyTalesMenuViewController.h"
#import <UIKit/UIKit.h>

static NSString* const keyShowAlphabetMenuSegue     =    @"showAlphabetMenuSegue";
static NSString* const keyInfoSegue                 =    @"infoSegue";
static NSString* const keyShowPicturesMenuSegue     =    @"showPicturesMenuSegue";
static NSString* const keyShowAllFairySegue         =    @"showAllFairyTalesSegue";
static NSString* const keyShowMagazineMenuSegue     =    @"showMagazineMenuSegue";
static NSString* const keyShowRequestSegue          =    @"showRequestSegue";


@interface MainMenuViewController ()
@property (strong, nonatomic) IBOutlet UIButton *alphabetMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *animalsMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *fairyTalesMenuButton;

@end

@implementation MainMenuViewController

- (IBAction) magazineMenuButton:(UIButton *)sender {
    
    [self performSegueWithIdentifier:keyShowMagazineMenuSegue
                              sender:nil];
}

- (IBAction)fairyTaileButton:(id)sender {
    [self performSegueWithIdentifier:keyShowAllFairySegue sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsCompact];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationController.navigationBar.tintColor =
    [UIColor colorWithRed:22.0/255.0 green:123.0/255.0 blue:33.0/255.0 alpha:1.0];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Артка" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (IBAction)openAnimalsMenuButton:(id)sender {
    
    [self performSegueWithIdentifier:keyShowPicturesMenuSegue
                              sender:nil];
}

- (IBAction)openAlphabetMenuButton:(id)sender {
    
//    CGRect rect = self.alphabetMenuButton.frame;
//    rect.size.width +=50;
//    rect.size.height +=50;
//    
//    [UIView animateWithDuration:0.1
//                          delay:0
//                        options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveLinear
//                     animations:^
//     {
//         self.alphabetMenuButton.frame = rect;
//     }
//                     completion:^(BOOL finished)
//     {
         [self performSegueWithIdentifier:keyShowAlphabetMenuSegue
                                   sender:nil];
//     }];
}


- (IBAction)infoButtonAction:(id)sender {
    [self performSegueWithIdentifier:keyInfoSegue
                              sender:nil];
    
}

- (IBAction) sendRequestAction:(id)sender {
    [self performSegueWithIdentifier:keyShowRequestSegue
                              sender:nil];
    
}

@end
