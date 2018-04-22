//
//  MainPageCollectionViewCell.h
//  Balastan
//
//  Created by Avaz on 25.05.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageCollectionViewCell : UICollectionViewCell

- (IBAction)textHidenAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *mainPageOutlet;
@property (strong, nonatomic) IBOutlet UIButton *textHidenOutlet;
@end
