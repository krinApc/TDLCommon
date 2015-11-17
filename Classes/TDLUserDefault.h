//
//  TDLUserDefault.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLUserDefault : NSObject

+ (void)setUserDefault:(id)data key:(NSString*)key;
+ (void)setIntergerUserDefault:(NSInteger)data key:(NSString*)key;
+ (void)setBoolUserDefault:(BOOL)data key:(NSString*)key;
+ (NSString*)getUserDefaultString:(NSString*)key;
+ (NSArray*)getUserDefaultArray:(NSString*)key;
+ (NSMutableArray*)getUserDefaultMutableArray:(NSString*)key;
+ (NSDictionary*) getUserDefaultDiction:(NSString*) key;
+ (NSMutableDictionary*) getUserDefaultMutableDiction:(NSString*) key;
+ (NSInteger)getUserDefaultInteger:(NSString*)key;
+ (float)getUserDefaultFloat:(NSString*)key;
+ (BOOL)getUserDefaultBool:(NSString*)key;

@end
