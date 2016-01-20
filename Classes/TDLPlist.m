//
//  TDLPlist.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLPlist.h"

@implementation TDLPlist

+ (id)getPlistArgumentInfoWithResource:(NSString*)resource key:(NSString*) key {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:resource ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return [dic objectForKey:key];
}

+ (NSDictionary*)getPlistDicInfoWithResource:(NSString*)resource key:(NSString*) key {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:resource ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return [dic objectForKey:key];
}

+ (NSArray*)getPlistArrayInfoWithResource:(NSString*)resource key:(NSString*) key {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:resource ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return [dic objectForKey:key];
}

+ (NSString*)getPlistStringInfoWithResource:(NSString*)resource key:(NSString*) key {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:resource ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *stg = [dic objectForKey:key];
    
    return stg;
}

@end
