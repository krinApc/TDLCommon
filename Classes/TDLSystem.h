//
//  TDLSystem.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2016/01/08.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLSystem : NSObject

+ (void)getLastestViewController:(void (^)(UIViewController *lastestviewController))resultBlock;
+ (float)getIosVersion;

@end
