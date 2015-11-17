//
//  TDLModelConverter.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLModelConverter.h"

@implementation TDLModelConverter

#pragma mark - common
// dicの中に指定したkeyが存在するか確認する
+ (BOOL)isFoundKey:(NSDictionary*)dic key:(NSString*)key {
    if ([[dic allKeys] containsObject:key] == NO) {
        return NO;
    }
    
    return YES;
}

// dicから指定したデータ型に値をセットする
+ (id)setValues:(NSDictionary*)dic typeObje:(id)typeObje {
    if(dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSEnumerator* enumDic = [dic keyEnumerator];
    for (NSString* key in enumDic) {
        
        // keyの一文字目を大文字にする
        NSString* stg = [self convertUppercaseStgForFirstStg:key];
        
        NSString* param = [NSString stringWithFormat:@"set%@:", stg];
        SEL sel = NSSelectorFromString(param);
        id arg = [dic objectForKey:key];
        
        if ([typeObje respondsToSelector:sel] == YES) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [typeObje performSelector:sel withObject:arg];
#pragma clang diagnostic pop
        }
    }
    return typeObje;
}

// 文字列の一文字目を大文字にする
+ (NSString*)convertUppercaseStgForFirstStg:(NSString*)string {
    // 一文字取り出し
    unichar cf = [string characterAtIndex:0];
    
    // 変換し
    NSString* upperFirst = [[NSMutableString stringWithCharacters:&cf length:1] uppercaseString];
    
    // 一文字目と差し替える
    NSMutableString* converted = [NSMutableString stringWithString:string];
    [converted replaceCharactersInRange:NSMakeRange(0, 1) withString:upperFirst];
    
    return converted;
}

@end
