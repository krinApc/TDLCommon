//
//  TDLAlertView.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLAlertView : NSObject

+ (void)showPromptAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed)) completion;
+ (void)showDetermineAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, BOOL agreed)) completion;
+ (void)showArgumentAlertWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons;

@end
