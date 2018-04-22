//
//  MagazineItem.h
//  Balastan
//
//  Created by Avaz on 18.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MagazineItem : JSONModel

@property (nonatomic, strong) NSString<Optional>* ID;
@property (strong, nonatomic) NSString<Optional>* audio;
@property (strong, nonatomic) NSString<Optional>* image;

@property (nonatomic, strong) NSString<Optional>* audioFile;
@property (nonatomic, strong) NSString<Optional>* imageFile;

@property (strong, nonatomic) NSNumber* number;
@property (strong, nonatomic) NSNumber* page;
@property (strong, nonatomic) NSString<Optional>* text;

@end
