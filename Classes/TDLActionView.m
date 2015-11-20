//
//  TDLActionView.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLActionView.h"
#import "UIActionSheet+Blocks.h"

@implementation TDLActionView

+ (UIViewController*)getLastestViewController {
    UIViewController *rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
    
    UIViewController *viewController = rootViewController;
    
    while (viewController != nil) {
        
        UIViewController *nowViewController = viewController.presentedViewController;
        
        if(nowViewController == nil) {
            break;
        }
        
        viewController = nowViewController;
    }
    
    return viewController;
}

+ (float)getIosVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void)showArgumentActionSheetWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons {
    
    UIViewController *viewController = [self getLastestViewController];
    
    if ([self getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) completion(YES, idx);
            }]];
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (completion) completion(YES, buttons.count);
        }]];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    } else {
        [UIActionSheet showInView:viewController.view
                        withTitle:title
                cancelButtonTitle:cancelButton
           destructiveButtonTitle:nil
                otherButtonTitles:buttons
                         tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                             if (completion) completion(YES, buttonIndex);
                         }];
    }
}

@end
