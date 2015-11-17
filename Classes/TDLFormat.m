//
//  TDLFormat.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLFormat.h"

@implementation TDLFormat

+ (BOOL)isEmptyString:(NSString*)stg {
    
    if(![stg isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if ([stg isEqual:[NSNull null]] || [stg length] == 0 || stg == nil || [stg isEqualToString:@"(null)"]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isNullNumber:(NSNumber*)num {
    if(![num isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    
    if([num isEqual:[NSNull null]] || num == nil || num == 0) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isAlphabet:(NSString*)checkString {
    NSMutableCharacterSet *alCharSet;
    alCharSet = [[NSMutableCharacterSet alloc] init];
    [alCharSet addCharactersInRange:NSMakeRange('a', 26)];
    [alCharSet addCharactersInRange:NSMakeRange('A', 26)];
    bool ret = [self chkCompareString:checkString baseString:alCharSet];
    return ret;
}

+ (BOOL)isNumeric:(NSString*)checkString {
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    bool ret = [self chkCompareString:checkString baseString:digitCharSet];
    return ret;
}

+ (BOOL)isAlphaNumeric:(NSString*)checkString {
    NSCharacterSet *alnumCharSet = [NSCharacterSet alphanumericCharacterSet]; // 英数字;
    bool ret = [self chkCompareString:checkString baseString:alnumCharSet];
    return ret;
}

+ (BOOL)chkCompareString:(NSString *)checkString baseString:(NSCharacterSet *)baseString {
    NSScanner *aScanner = [NSScanner localizedScannerWithString:checkString];
    
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:baseString intoString:NULL];
    return [aScanner isAtEnd];
}

+ (BOOL)isEmail:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailCheck evaluateWithObject:email];
}

@end
