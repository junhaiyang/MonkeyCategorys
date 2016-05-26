

#import <UIKit/UIKit.h>


extern NSString * const UIResponderNotificationCategoryIdent;

@interface UIResponder(AddInterceptor)
 

- (void)registerApplicationRemoteNotification;

@end

@interface UIApplication(AddInterceptor)


-(void)activateRemoteNotification;
-(void)delayReceiveRemoteNotification;

-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;

@end

@interface UIInterceptorApplication : UIApplication
 

@end
