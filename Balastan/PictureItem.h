//
//  FruitItem.h
//  Balastan
//
//  Created by Avaz on 3/6/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PictureItem : JSONModel

@property(strong, nonatomic) NSString* pictureImage;
@property(strong, nonatomic) NSString* pictureWordString;
@property(strong, nonatomic) NSString* audioWord;

@end
