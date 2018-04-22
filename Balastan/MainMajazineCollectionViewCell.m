//
//  MainMajazineCollectionViewCell.m
//  Balastan
//
//  Created by Avaz on 19.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MainMajazineCollectionViewCell.h"
#import <Quickblox/Quickblox.h>
#import "MagazineDownloader.h"


@implementation MainMajazineCollectionViewCell


- (IBAction)DownloadButton:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadProgress" object: sender];
}

@end
