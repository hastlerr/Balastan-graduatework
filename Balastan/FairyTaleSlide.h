//
//  FairyTaleSlide.h
//  Balastan
//
//  Created by Avaz on 3/3/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol FairyTaleSlide;

@interface FairyTaleSlide : JSONModel

@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSString* fairyTaleCurrentImage;

@end
