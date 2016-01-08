//
//  TDLSystem.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2016/01/08.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import "TDLSystem.h"

@implementation TDLSystem

+ (void)getLastestViewController:(void (^)(UIViewController *lastestviewController))resultBlock {
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        UIViewController *rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
        
        UIViewController *viewController = rootViewController;
        
        while (viewController != nil) {
            
            UIViewController *nowViewController = viewController.presentedViewController;
            
            if(nowViewController == nil) {
                break;
            }
            
            viewController = nowViewController;
        }
        
        if (resultBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(viewController);
            });
        }
    });
}

+ (float)getIosVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

@end
