//
//  TDLUserDefault.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLUserDefault.h"

@implementation TDLUserDefault

+ (void)setUserDefault:(id)data key:(NSString*)key {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:data forKey:key];
    [ud synchronize];
}

+ (void)setIntergerUserDefault:(NSInteger)data key:(NSString*)key {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:data forKey:key];
    [ud synchronize];
}

+ (void)setBoolUserDefault:(BOOL)data key:(NSString*)key {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:data forKey:key];
    [ud synchronize];
}

+ (NSString*)getUserDefaultString:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (NSArray*)getUserDefaultArray:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:key];
}

+ (NSMutableArray*)getUserDefaultMutableArray:(NSString*)key {
    return [[[NSUserDefaults standardUserDefaults] arrayForKey:key] mutableCopy];
}

+ (NSDictionary*) getUserDefaultDiction:(NSString*) key {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}

+ (NSMutableDictionary*) getUserDefaultMutableDiction:(NSString*) key {
    return [[[NSUserDefaults standardUserDefaults] dictionaryForKey:key] mutableCopy];
}

+ (NSInteger)getUserDefaultInteger:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (float)getUserDefaultFloat:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (BOOL)getUserDefaultBool:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
