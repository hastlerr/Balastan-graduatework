//
//  MagazineCover.m
//  Balastan
//
//  Created by Avaz on 29.04.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "MagazineCover.h"

@implementation MagazineCover

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.coverImage =
        [aDecoder decodeObjectForKey:@"coverImage"];
        
        self.coverDownloadStatus =
        [aDecoder decodeBoolForKey:@"coverDownloadStatus"];
        
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
    [aCoder encodeObject:self.coverImage
                  forKey:@"coverImage"];
    
    [aCoder encodeBool:self.coverDownloadStatus
                forKey:@"coverDownloadStatus"];
     
    
}

@end
