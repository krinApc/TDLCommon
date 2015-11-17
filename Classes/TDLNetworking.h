//
//  TDLNetworking.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TDLNetworking : NSObject

+ (void)commonGetWithUrlStr:(NSString*) urlStr
                      param:(NSDictionary*) param
                    Success:(void (^)(NSDictionary *resultDic))successBlock
                    failure:(void (^)(NSError *error))failureBlock;

+ (void)commonPostWithUrlStr:(NSString*) urlStr
                       param:(NSDictionary*) param
                     Success:(void (^)(NSDictionary *resultDic))successBlock
                     failure:(void (^)(NSError *error))failureBlock;

+ (void)commonDeleteWithUrlStr:(NSString*) urlStr
                          param:(NSDictionary*) param
                        Success:(void (^)(NSDictionary *resultDic))successBlock
                        failure:(void (^)(NSError *error))failureBlock;

+ (void)commonPutWithUrlStr:(NSString*) urlStr
                      param:(NSDictionary*) param
                    Success:(void (^)(NSDictionary *resultDic))successBlock
                    failure:(void (^)(NSError *error))failureBlock;

+(void) commonUploadImageWithUrlStr:(NSString*) urlStr
                              param:(NSDictionary*) param
                              image:(UIImage*) image
                           fileName:(NSString*) fileName
                            success:(void (^)(NSDictionary *))successBlock
                            failure:(void (^)(NSError *))failureBlock;

+ (void)commonUploadImageByOriginWithUrlStr:(NSString*) urlStr
                                      param:(NSDictionary*) param
                                      image:(UIImage*) image
                                   fileName:(NSString*) fileName
                                    success:(void (^)(NSDictionary *resultDic))successBlock
                                    failure:(void (^)(NSError *error))failureBlock;

@end
