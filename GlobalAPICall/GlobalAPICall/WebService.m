//
//  WebService.m
//  GlobalAPICall
//
//  Created by Ravi Dhorajiya on 28/05/17.
//  Copyright © 2017 Ravi Dhorajiya. All rights reserved.
//

#import "WebService.h"
#import "Reachability.h"

@implementation WebService

- (void)viewDidLoad
{
    [self viewDidLoad];
}

+ (void)callApiWithParameters:(NSDictionary *)parameters apiName:(NSString *)apiName type:(NSString *)type loader:(BOOL)isLoaderNeed responseData:(void (^)(NSDictionary *, NSError *))responseData
{
    //Internet Connection Check Here!
    if ([type isEqualToString:POST_REQUEST])
    {
        if ([WebService internetConnectionCheck])
        {
            if (isLoaderNeed==YES) {
                [Utility ShowProgress];
            }
            NSLog(@"==============  API URL  ====================");
            NSLog(@"%@",apiName);
            NSLog(@"=============================================");
            
            __block NSDictionary * dictResponse = nil;
            
            NSMutableURLRequest *request;
            
            if (parameters != nil)
            {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:nil];
                // request = [NSMutableURLRequest requestWithURL:urlRequestString];
                request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:apiName] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
                [request setHTTPMethod:type];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:jsonData];
                
            }
            
            
            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data , NSURLResponse *response , NSError *err)
              {
                  NSLog(@"==============  PARAMETER  ==================");
                  NSLog(@"%@",parameters);
                  NSLog(@"=============================================");
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      
                      [Utility hideProgress];
                      NSError *jsonError;
                      
                      if (data)
                      {
                          dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                          
                          if (responseData != NULL) {
                              responseData(dictResponse,jsonError);
                          }
                          
                          NSLog(@"==============  RESPONSE  ==================");
                          NSLog(@"%@",dictResponse);
                          NSLog(@"=============================================");
                          
                      }
                      else if(err)
                      {
                          NSString *errorMsg;
                          if ([[err domain] isEqualToString:NSURLErrorDomain]) {
                              switch ([err code]) {
                                  case NSURLErrorTimedOut:
                                      [self connectionTimeOut];
                                      errorMsg = NSLocalizedString(@"NSURLErrorTimedOut", nil);
                                      break;
                                      
                                  default:
                                      errorMsg = [err localizedDescription];
                                      break;
                              }
                          } else {
                              errorMsg = [err localizedDescription];
                          }
                      }
                  });
              }]
             resume];
        }
        else
        {
            [Utility hideProgress];
            [self AlertMessage:@"Check Your Internet Connection!"];
        }
    }
    else
    {
        if ([WebService internetConnectionCheck])
        {
            if (isLoaderNeed==YES) {
                [Utility ShowProgress];
            }
            
            __block NSDictionary * dictResponse = nil;
            
            NSString *apiNameConvert = [apiName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSLog(@"==============  API URL  ====================");
            NSLog(@"%@",apiNameConvert);
            NSLog(@"=============================================");
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:apiNameConvert]];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPMethod:GET_REQUEST];
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [Utility hideProgress];
                    NSError *jsonError;
                    
                    if (data)
                    {
                        dictResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&jsonError];
                        
                        if (responseData != NULL) {
                            responseData(dictResponse,jsonError);
                        }
                        
                        NSLog(@"==============  RESPONSE  ==================");
                        NSLog(@"%@",dictResponse);
                        NSLog(@"=============================================");
                        
                    }
                    else if(error)
                    {
                        NSString *errorMsg;
                        if ([[error domain] isEqualToString:NSURLErrorDomain]) {
                            switch ([error code]) {
                                case NSURLErrorTimedOut:
                                    [self connectionTimeOut];
                                    errorMsg = NSLocalizedString(@"NSURLErrorTimedOut", nil);
                                    break;
                                    
                                default:
                                    errorMsg = [error localizedDescription];
                                    break;
                            }
                        } else {
                            errorMsg = [error localizedDescription];
                        }
                    }
                });
            }] resume];
        }
        else
        {
            [Utility hideProgress];
            [self AlertMessage:@"Check Your Internet Connection!"];
        }
    }
    
    
    //If any request want to cance then we can used this following method
    //[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(callApiWithParameters:apiName:type:loader:message:) object:nil];
    
}

+ (void)connectionTimeOut
{
    [self AlertMessage:@"Check Your Internet Connection!! \n Then Click Again"];
}

+ (void)AlertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:APP_NAME message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
}

#pragma arguments
+ (BOOL)internetConnectionCheck
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}



@end
