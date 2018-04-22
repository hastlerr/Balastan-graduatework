//
//  APIClient.h
//  Balastan
//
//  Created by Avaz on 19.08.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSArray* result);
typedef void(^errorB)(NSError* error);

@interface APIClient : NSObject

- (void) postClaimWithName: (NSString*) name
               phoneNumber:(NSString*) number
                complition:(successBlock) successBlock
                     error:(errorB) errorBlock;
@end

