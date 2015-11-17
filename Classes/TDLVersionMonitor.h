//
//  TDLVersionMonitor.h
//  
//
//  Created by 林浩智 on 2015/11/16.
//
//

#import <Foundation/Foundation.h>

@interface TDLVersionMonitor : NSObject

+ (TDLVersionMonitor*)sharedManager;
- (void)excuteVersionMonitorWithUpdateUrlString:(NSString*)urlStr alertTitle:(NSString*)title alertMessage:(NSString*)message;

@end
