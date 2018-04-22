//
//  TheMagazine.m
//  Balastan
//
//  Created by Avaz on 14.05.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "TheMagazine.h"

@implementation TheMagazine
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pages = [NSMutableArray new];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.pages =
        [aDecoder decodeObjectForKey:@"journalWithPages"];
        
        self.parentID =
        [aDecoder decodeObjectForKey:@"journalWithParentID"];

        self.dowloadedStatus =
        [aDecoder decodeBoolForKey:@"dowloadedStatus"];
        
    }
    return self;
}
/*
 Метод вызывается при сохраннии данных объекта,
 здесь мы должны записать данные объекта которые хотим сохранить в специальный объект aCoder
 */
- (void) encodeWithCoder:(NSCoder*) aCoder
{
    // Сохраняем
    [aCoder encodeObject:self.pages
                  forKey:@"journalWithPages"];
    
    [aCoder encodeObject:self.parentID
                  forKey:@"journalWithParentID"];
    
    [aCoder encodeBool:self.dowloadedStatus
                forKey:@"dowloadedStatus"];
    
    
}
@end
