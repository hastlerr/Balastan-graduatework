//
//  LetterItem.h
//  Balastan
//
//  Created by Avaz on 2/22/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <JSONModel/JSONModel.h>

@interface LetterItem : JSONModel

@property(strong, nonatomic) NSString* letterImage;
@property(strong, nonatomic) NSString* letterWordImage;
@property(strong, nonatomic) NSString* letterExampleImage;
@property(strong, nonatomic) NSString* audioLetter;
@property(strong, nonatomic) NSString* audioWord;

@end
