//
//  MainPageCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 25.05.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MainPageCollectionViewCell.h"

@implementation MainPageCollectionViewCell

- (IBAction)textHidenAction:(id)sender {


    if(self.textOutlet.layer.hidden == YES){
        self.textOutlet.layer.hidden = NO;
        [self.textHidenOutlet setImage:[UIImage imageNamed:@"menu_down"]
                                 forState:UIControlStateNormal];
    } else {
        self.textOutlet.layer.hidden = YES;
        [self.textHidenOutlet setImage:[UIImage imageNamed:@"menu_up"]
                                 forState:UIControlStateNormal];
    
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textHidden" object:
     self.textOutlet];

}

@end
