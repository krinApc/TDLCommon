//
//  TDLActionView.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLActionView.h"
#import "UIActionSheet+Blocks.h"
#import "TDLSystem.h"

@implementation TDLActionView

+ (void)showArgumentActionSheetWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons {
    
    [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
        if ([TDLSystem getIosVersion] >= 8.0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            
            [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
                [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (completion) completion(YES, idx+1);
                }]];
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (completion) completion(YES, 0);
            }]];
            
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        } else {
            [UIActionSheet showInView:lastestviewController.view
                            withTitle:title
                    cancelButtonTitle:cancelButton
               destructiveButtonTitle:nil
                    otherButtonTitles:buttons
                             tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                                 if (completion) completion(YES, buttonIndex);
                             }];
        }
    }];
}

@end
