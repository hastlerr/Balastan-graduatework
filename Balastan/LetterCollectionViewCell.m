//
//  LetterCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 2/24/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "LetterCollectionViewCell.h"

@implementation LetterCollectionViewCell

-(void) setLetter:(LetterItem *)letter{
    if(_letter != letter) {
        _letter= letter;
    }
    
    self.letterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [_letter letterImage]]];
    
    self.letterWordImageView.image= [UIImage imageNamed:[NSString stringWithFormat:@"%@", [_letter letterWordImage]]];
    self.letterExampleImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", [_letter letterExampleImage]]];
}

@end
