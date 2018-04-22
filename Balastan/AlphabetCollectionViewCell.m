//
//  LetterCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 2/20/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "AlphabetCollectionViewCell.h"

@implementation AlphabetCollectionViewCell

-(void) setLetterImage:(UIImage *)letterImage{
    if(_letterImage != letterImage) {
        _letterImage = letterImage;
    }
    
    self.letterImageView.image = _letterImage;
    self.letterImageView.layer.cornerRadius=7;

}

@end
