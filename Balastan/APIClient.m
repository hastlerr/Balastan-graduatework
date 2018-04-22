//
//  APIClient.m
//  Balastan
//
//  Created by Avaz on 19.08.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "APIClient.h"
#import <AFNetworking.h>

@interface APIClient ()
@property (nonatomic, strong) AFHTTPSessionManager* manager;
@property (nonatomic, strong) NSArray* services;
@end

@implementation APIClient

- (instancetype)init{
    self = [super init];
    
    if (self)
    {
        self.services = [NSArray new];
        self.manager = [AFHTTPSessionManager manager];
    }
    return self;
}


#pragma mark - POST request

- (void) postClaimWithName: (NSString*) name
               phoneNumber:(NSString*) number
                complition:(successBlock) successBlock
                     error:(errorB) errorBlock{
    
    NSDictionary *params = @{@"name": [NSString stringWithFormat:@"%@", name],
                             @"number": [NSString stringWithFormat:@"%@", number]
                             };

    
    [self.manager POST:@"http://176.126.167.231:86/send/"
            parameters:params
              progress:^(NSProgress* uploadProgress)
     {
         
     }
               success:^(NSURLSessionDataTask* task, id responseObject) {
                   successBlock(responseObject);
               }
               failure:^(NSURLSessionDataTask* task, NSError* error)
     {
         errorBlock(error);
     }];
}


@end
