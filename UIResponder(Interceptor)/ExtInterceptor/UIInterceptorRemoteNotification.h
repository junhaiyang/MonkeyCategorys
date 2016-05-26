 

#import <Foundation/Foundation.h>

/**
 *
 * 推送通知延迟处理策略，用于启动时和点击通知消息后重新启动app后，逻辑上不想立即执行推送处理，期望执行其它逻辑后再执行
 *
 */

@class UIResponderInterceptorMethod;

@interface UIInterceptorRemoteNotification : NSObject

@property (nonatomic,weak) UIResponderInterceptorMethod *interceptorMethod;


- (void)willChangeApplicationState:(UIApplicationState)applicationState;

- (void)activateRemoteNotification;
- (void)delayReceiveRemoteNotification;

- (BOOL)willExecuteImmediately;

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end
