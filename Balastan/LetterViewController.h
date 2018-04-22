//
//  LetterViewController.h
//  Balastan
//
//  Created by Avaz on 2/22/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LetterItem.h"
#import <JSONModel/JSONModel.h>

@interface LetterViewController : UIViewController

@property(strong, nonatomic) NSArray<LetterItem*> * letterArray;
@property(assign, nonatomic) NSInteger letterIndex;

- (IBAction)nextButton:(id)sender;
- (IBAction)previousButton:(id)sender;

@end
