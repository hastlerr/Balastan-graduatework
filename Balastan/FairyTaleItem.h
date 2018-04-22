//
//  FairyTaleItem.h
//  Balastan
//
//  Created by Avaz on 2/27/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FairyTaleSlide.h"


@interface FairyTaleItem : JSONModel

@property(strong, nonatomic) NSString* fairyTaleNameImage;
@property(strong, nonatomic) NSString* audioFairyTale;
@property(strong, nonatomic) NSArray<FairyTaleSlide>* slides;

@end
