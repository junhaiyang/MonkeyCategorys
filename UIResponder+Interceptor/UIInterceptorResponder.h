 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIResponderInterceptorMethod;

@interface UIInterceptorResponder : NSObject<UIApplicationDelegate>

@property (nonatomic,weak) UIResponderInterceptorMethod *interceptorMethod;

-(void)activateRemoteNotification;
-(void)delayReceiveRemoteNotification;

@end