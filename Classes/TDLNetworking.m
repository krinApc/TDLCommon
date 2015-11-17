//
//  TDLNetworking.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLNetworking.h"
#import "AFNetworking.h"

NSString * const TDLNetworkingErrorDomain = @"TDLNetworkingErrorDomain";

@implementation TDLNetworking

/*************************
Just some samples. If you want to use it, please copy these methods and merge it in your own project
*************************/

+ (void)commonGetWithUrlStr:(NSString*) urlStr
                      param:(NSDictionary*) param
                    Success:(void (^)(NSDictionary *resultDic))successBlock
                    failure:(void (^)(NSError *error))failureBlock {
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:urlStr
      parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSInteger statusCode = operation.response.statusCode;
          
          if(statusCode != 200) {
              NSLog(@"GET ERROR: statusCode = %ld\nurl = %@\nparam = %@",(long)statusCode,urlStr,param);
              if (failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:statusCode userInfo:nil]);
          } else {
              if (successBlock) successBlock(responseObject);
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"GET ERROR: %@\nurl = %@\nparam = %@",operation.responseString,urlStr,param);
          if (failureBlock) failureBlock(error);
      }];
}

+ (void)commonPostWithUrlStr:(NSString*) urlStr
                       param:(NSDictionary*) param
                     Success:(void (^)(NSDictionary *resultDic))successBlock
                     failure:(void (^)(NSError *error))failureBlock {
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlStr
       parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           NSInteger statusCode = operation.response.statusCode;
           
           if(statusCode != 200 && statusCode != 201) {
               NSLog(@"POST ERROR: statusCode = %ld\nurl = %@\nparam = %@",(long)statusCode,urlStr,param);
               if (failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:statusCode userInfo:nil]);
           } else {
               if (successBlock) successBlock(responseObject);
           }
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"POST ERROR: %@\nurl = %@\nparam = %@",operation.responseString,urlStr,param);
           if (failureBlock) failureBlock(error);
       }];
}

+ (void)commonDeleteWithUrlStr:(NSString*) urlStr
                         param:(NSDictionary*) param
                       Success:(void (^)(NSDictionary *resultDic))successBlock
                       failure:(void (^)(NSError *error))failureBlock {
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager DELETE:urlStr
         parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSInteger statusCode = operation.response.statusCode;
             
             if(statusCode != 200) {
                 NSLog(@"DELETE ERROR: statusCode = %ld\nurl = %@\nparam = %@",(long)statusCode,urlStr,param);
                 if (failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:statusCode userInfo:nil]);
             } else {
                 if (successBlock) successBlock(responseObject);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"DELETE ERROR: %@\nurl = %@\nparam = %@",operation.responseString,urlStr,param);
             if (failureBlock) failureBlock(error);
         }];
}

+ (void)commonPutWithUrlStr:(NSString*) urlStr
                      param:(NSDictionary*) param
                    Success:(void (^)(NSDictionary *resultDic))successBlock
                    failure:(void (^)(NSError *error))failureBlock {
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = operation.response.statusCode;
        
        if(statusCode != 200) {
            NSLog(@"PUT ERROR: statusCode = %ld\nurl = %@\nparam = %@",(long)statusCode,urlStr,param);
            if (failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:statusCode userInfo:nil]);
        } else {
            if (successBlock) successBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"PUT ERROR: %@\nurl = %@\nparam = %@",operation.responseString,urlStr,param);
        if(failureBlock) failureBlock(error);
    }];
}

+(void) commonUploadImageWithUrlStr:(NSString*) urlStr
                              param:(NSDictionary*) param
                              image:(UIImage*) image
                           fileName:(NSString*) fileName
                            success:(void (^)(NSDictionary *))successBlock
                            failure:(void (^)(NSError *))failureBlock {
    if(param != nil) {
        NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
        
        if(imageData != nil) {
            AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            NSArray *responseSerializers =@[[AFJSONResponseSerializer serializer]];
            
            manager.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:responseSerializers];
            
            NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                                           URLString:urlStr
                                                                                          parameters:param
                                                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                               [formData appendPartWithFileData:imageData
                                                                                                           name:@"image"
                                                                                                       fileName:fileName
                                                                                                       mimeType:@"image/png"];
                                                                           }
                                                                                               error:NULL];
            
            
            AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                     NSInteger statusCode = operation.response.statusCode;
                                                                                     
                                                                                     if(statusCode != 201) {
                                                                                         NSLog(@"ERROR statusCode = %ld",(long)statusCode);
                                                                                         if (failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:statusCode userInfo:nil]);
                                                                                     } else {
                                                                                         if (successBlock) successBlock(responseObject);
                                                                                     }
                                                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                     NSLog(@"%@",error);
                                                                                     if (failureBlock) failureBlock(error);
                                                                                 }];
            
            // データを送信する度に実行される処理を設定する
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                // アップロード中の進捗状況をコンソールに表示する
                NSLog(@"bytesWritten: %@, totalBytesWritten: %@, totalBytesExpectedToWrite: %@, progress: %@",
                      @(bytesWritten),
                      @(totalBytesWritten),
                      @(totalBytesExpectedToWrite),
                      @((float)totalBytesWritten / totalBytesExpectedToWrite));
            }];
            
            // アップロードを開始する
            [manager.operationQueue addOperation:operation];
            
        } else {
            if(failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:9999 userInfo:nil]);
        }
        
    } else {
        if(failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:9999 userInfo:nil]);
    }
}

+ (void)commonUploadImageByOriginWithUrlStr:(NSString*) urlStr
                              param:(NSDictionary*) param
                              image:(UIImage*) image
                           fileName:(NSString*) fileName
                            success:(void (^)(NSDictionary *resultDic))successBlock
                            failure:(void (^)(NSError *error))failureBlock {
    
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
    
    if (imageData != nil) {
        //adding header information
        NSString *stringBoundary = @"0xKhTmLbOuNdArY";
        NSMutableData *httpBody = [NSMutableData data];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        
        // set content type
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        // add params (all params are strings)
        for (id key in param) {
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", [param objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        // add image data
        if (imageData) {
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[NSData dataWithData:imageData]];
            [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the reqeust
        [request setHTTPBody:httpBody];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"Error: ***** %@", error);
                    if (failureBlock) failureBlock(error);
                    
                    return;
                }
                
                NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", returnString);
                
                NSError *jsonError;
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                if (error) {
                    NSLog(@"Error: ***** %@", jsonError);
                    if (failureBlock) failureBlock(jsonError);
                    
                    return;
                }
                
                if (successBlock) successBlock(jsonObject);
            });
            
            
        }];
    } else {
        if(failureBlock) failureBlock([NSError errorWithDomain:TDLNetworkingErrorDomain code:9999 userInfo:nil]);
    }
}

@end
