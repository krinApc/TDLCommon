//
//  TDLSheetView.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2016/01/21.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import "TDLSheetView.h"
#import "TDLSystem.h"
#import "UIActionSheet+Blocks.h"

@implementation TDLSheetView

+ (void)showArgumentActionSheetWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons {
    
    if ([TDLSystem getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) completion(YES, idx);
            }]];
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (completion) completion(YES, buttons.count);
        }]];
        
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [UIActionSheet showInView:lastestviewController.view
                            withTitle:title
                    cancelButtonTitle:cancelButton
               destructiveButtonTitle:nil
                    otherButtonTitles:buttons
                             tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                                 if (completion) completion(YES, buttonIndex);
                             }];
        }];
    }
}

@end
