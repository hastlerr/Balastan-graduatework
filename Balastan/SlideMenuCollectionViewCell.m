//
//  PictureMenuCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "SlideMenuCollectionViewCell.h"

@implementation SlideMenuCollectionViewCell

-(void) setPictureImage:(UIImage *)pictureImage{
    if(_pictureImage != pictureImage) {
        _pictureImage = pictureImage;
    }
    
    self.pictureImageView.image = _pictureImage;
    self.pictureImageView.layer.cornerRadius=7;
    
}

@end
