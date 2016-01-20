//
//  TDLPlist.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLPlist : NSObject

+ (id)getPlistArgumentInfoWithResource:(NSString*)resource key:(NSString*) key;
+ (NSDictionary*)getPlistDicInfoWithResource:(NSString*)resource key:(NSString*) key;
+ (NSArray*)getPlistArrayInfoWithResource:(NSString*)resource key:(NSString*) key;
+ (NSString*)getPlistStringInfoWithResource:(NSString*)resource key:(NSString*) key;

@end
