//
//  TDLAlertView.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLAlertView.h"
#import "UIAlertView+Blocks.h"
#import "TDLSystem.h"

@implementation TDLAlertView

#pragma mark -- Alert with only confirm button
+ (void)showPromptAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed)) completion {
    if ([TDLSystem getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) completion(YES);
        }]];
        
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:NSLocalizedString(@"OK", nil)
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (completion) completion(YES);
                          }];
    }
}

#pragma mark -- Alert with choosen
+ (void)showDetermineAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, BOOL agreed)) completion {
    if ([TDLSystem getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"いいえ", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) completion(YES, NO);
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"はい", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) completion(YES, YES);
        }]];
        
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:NSLocalizedString(@"いいえ", nil)
                 otherButtonTitles:@[NSLocalizedString(@"はい", nil)]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  if (completion) completion(YES, NO);
                              } else if (buttonIndex == 1) {
                                  if (completion) completion(YES, YES);
                              }
                          }];
    }
}

#pragma mark -- Alert with arguments
+ (void)showArgumentAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons {
    
    if ([TDLSystem getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) completion(YES, 0);
        }]];
        
        [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) completion(YES, idx+1);
            }]];
        }];
        
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:NSLocalizedString(@"閉じる", nil)
                 otherButtonTitles:buttons
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (completion) completion(YES, buttonIndex);
                          }];
    }
}

@end
