//
//  TDLFormat.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLFormat : NSObject

+ (BOOL)isEmptyString:(NSString*)stg;
+ (BOOL)isNullNumber:(NSNumber*)num;
+ (BOOL)isAlphabet:(NSString*)checkString;
+ (BOOL)isNumeric:(NSString*)checkString;
+ (BOOL)isAlphaNumeric:(NSString*)checkString;
+ (BOOL)isEmail:(NSString*)email;

@end
