//
//  PictureCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 3/7/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell

-(void) setPicture:(PictureItem *)picture{
    if(_picture != picture) {
        _picture= picture;
    }
    
    self.pictureImageView.image = [UIImage imageNamed:[_picture pictureImage]];
    
    
    self.pictureWord.text=[NSString stringWithFormat:@"%@", [_picture pictureWordString]];
}

@end
