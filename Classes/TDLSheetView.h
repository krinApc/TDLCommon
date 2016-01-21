//
//  TDLSheetView.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2016/01/21.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLSheetView : NSObject

+ (void)showArgumentActionSheetWithTitle:(NSString*) title message:(NSString*) message completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion cancelButton:(NSString*) cancelButton buttons:(NSArray*) buttons;

@end
