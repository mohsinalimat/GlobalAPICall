//
//  WebService.h
//  GlobalAPICall
//
//  Created by Ravi Dhorajiya on 28/05/17.
//  Copyright © 2017 Ravi Dhorajiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebService : NSObject

@property (copy, nonatomic) void (^responseData)(NSDictionary *response, NSError *error);

//Api Call
+(void)callApiWithParameters:(NSDictionary *)parameters
                     apiName:(NSString *)apiName
                        type:(NSString*)type
                      loader:(BOOL)isLoaderNeed
                responseData:(void (^)(NSDictionary *response, NSError *error))responseData;

@end
