//
//  TDLVersionMonitor.m
//  
//
//  Created by 林浩智 on 2015/11/16.
//
//

#import "TDLVersionMonitor.h"
#import <UIKit/UIKit.h>

typedef enum {
    TDLVersionUpdateTypeForce,
    TDLVersionUpdateTypeCommon
}TDLVersionUpdateType;

static TDLVersionMonitor* sharedManager = nil;
static NSString * const TDLSkipVersion = @"TDLSkipVersion";

@interface TDLVersionMonitor()

@property (copy, nonatomic) NSDictionary *jsonObject;

@end

@implementation TDLVersionMonitor {
    NSString *_requiredVersion;
    TDLVersionUpdateType _type;
    NSString *_updateUrl;
    
    NSString *_title;
    NSString *_message;
}

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)setJsonObject:(NSDictionary *)jsonObject {
    _jsonObject = jsonObject;
    
    _requiredVersion = jsonObject[@"required_version"];
    NSString *typeStr = jsonObject[@"type"];
    _type = [typeStr isEqualToString:@"force"]? TDLVersionUpdateTypeForce : TDLVersionUpdateTypeCommon;
    _updateUrl = jsonObject[@"update_url"];
}

- (void)excuteVersionMonitorWithUpdateUrlString:(NSString*)urlStr alertTitle:(NSString*)title alertMessage:(NSString*)message {
    
    _title = title;
    _message = message;
    
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        NSURL *updateUrl = [NSURL URLWithString:urlStr];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:updateUrl
                                                    cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                timeoutInterval:20.0];
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&error];
        
        if (error) {
            NSLog(@"TDLVersionMonitor excute error:%@",[error description]);
            return;
        }
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (error) {
            NSLog(@"TDLVersionMonitor excute error:%@",[error description]);
            return;
        }
        
        self.jsonObject = jsonObject;
        
        [self responceHandler];
        
    });
}

- (void)responceHandler {
    
    if ([self isMistakenJson]) {
        NSLog(@"TDLVersionMonitor json mistaken:%@",self.jsonObject);
        return;
    }
    
    if ([self isNeedToUpdateVerstion]) {
        [self showAlert];
    }
}

#pragma mark - common methods
- (BOOL)isMistakenJson {
    return (_requiredVersion == nil || _requiredVersion.length == 0 || _updateUrl == nil || _updateUrl.length == 0);
}

- (BOOL)isNeedToUpdateVerstion {
    return  ([_requiredVersion compare:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] options:NSNumericSearch] == NSOrderedDescending)
            && ![_requiredVersion isEqualToString:[self getSkipVersion]];
}

- (void)setSkipVersion {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_requiredVersion forKey:TDLSkipVersion];
    [ud synchronize];
}

- (NSString*)getSkipVersion {
    NSString *skipStr = [[NSUserDefaults standardUserDefaults] stringForKey:TDLSkipVersion];
    return skipStr;
}

#pragma mark - alert methods
- (void)showAlert {
    Class class = NSClassFromString(@"UIAlertController");
    
    NSArray *otherButtonTitles = nil;
    NSString *title = _title == nil? @"アップデート通知" : _title;
    NSString *message = _message == nil? @"新しバージョンがリリースされました。\nAppleStoreへ遷移して更新します。" : _message;
    
    switch (_type) {
        case TDLVersionUpdateTypeCommon:
            otherButtonTitles = @[@"このバージョンをスッキプ",@"アップデートしない"];
            break;
            
        default:
            break;
    }
    
    if(class) {
        
        UIAlertController *alert = nil;
        alert = [UIAlertController alertControllerWithTitle:title
                                                    message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
        
        
        [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL *stop) {
            [alert addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        if (idx == 0) {
                                                            [self tapSkipButton];
                                                        }
                                                    }]];
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [self tapUpdateButton];
                                                }]];
        
        [[self getLastestViewController] presentViewController:alert animated:YES completion:nil];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            alertView.delegate = self;
            
            [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL *stop) {
                [alertView addButtonWithTitle:buttonTitle];
            }];
            
            [alertView show];
        });
    }
}

- (UIViewController*)getLastestViewController {
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

#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self tapUpdateButton];
            break;
            
        case 1:
            [self tapSkipButton];
            break;
        default:
            break;
    }
}

#pragma mark - button methods
- (void)tapUpdateButton {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_updateUrl]];
}

- (void)tapSkipButton {
    [self setSkipVersion];
}

@end
