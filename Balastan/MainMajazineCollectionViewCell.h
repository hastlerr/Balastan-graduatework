//
//  MainMajazineCollectionViewCell.h
//  Balastan
//
//  Created by Avaz on 19.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMajazineCollectionViewCell : UICollectionViewCell

- (IBAction)DownloadButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *magazineImageView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButtonOutlet;

@end
