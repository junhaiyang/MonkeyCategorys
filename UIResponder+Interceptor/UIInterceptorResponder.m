 

#import "UIInterceptorResponder.h"

#import "UIResponderInterceptorMethod.h" 
#import "UIInterceptorRemoteNotification.h"


@interface UIInterceptorResponder()<UIApplicationDelegate>{
}
@property (nonatomic,strong) UIInterceptorRemoteNotification *interceptorRemoteNotification;

@end

@implementation UIInterceptorResponder
@synthesize interceptorMethod;
@synthesize interceptorRemoteNotification;
- (instancetype)init
{
    self = [super init];
    if (self) {
        interceptorRemoteNotification = [UIInterceptorRemoteNotification new];
        
    }
    return self;
}
-(void)setInterceptorMethod:(UIResponderInterceptorMethod *)_interceptorMethod{
    interceptorMethod =_interceptorMethod;
    interceptorRemoteNotification.interceptorMethod = _interceptorMethod;
}

-(void)activateRemoteNotification{
    [interceptorRemoteNotification activateRemoteNotification];
}
-(void)delayReceiveRemoteNotification{
    [interceptorRemoteNotification delayReceiveRemoteNotification];
}

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"application:didFinishLaunchingWithOptions:");
    
    return  [interceptorMethod.originalTarget application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
    
    if([interceptorMethod.originalTarget respondsToSelector:@selector(applicationWillResignActive:)]){
        [interceptorMethod.originalTarget applicationWillResignActive:application];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    if([interceptorMethod.originalTarget respondsToSelector:@selector(applicationDidEnterBackground:)]){
        [interceptorMethod.originalTarget applicationDidEnterBackground:application];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    
    if([interceptorMethod.originalTarget respondsToSelector:@selector(applicationDidBecomeActive:)]){
        [interceptorMethod.originalTarget applicationDidBecomeActive:application];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    
    if([interceptorMethod.originalTarget respondsToSelector:@selector(applicationWillTerminate:)]){
        [interceptorMethod.originalTarget applicationWillTerminate:application];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    if([interceptorRemoteNotification willExecuteImmediately]){
        
        if([interceptorMethod.originalTarget respondsToSelector:@selector(application:didReceiveRemoteNotification:)]){
            [interceptorMethod.originalTarget application:application didReceiveRemoteNotification:userInfo];
        }
    }else{
        [interceptorRemoteNotification didReceiveRemoteNotification:userInfo];
    }
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    if([interceptorRemoteNotification willExecuteImmediately]){
        
        if([interceptorMethod.originalTarget respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]){
            [interceptorMethod.originalTarget application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }else{
            //没有方法 扔掉
            completionHandler(UIBackgroundFetchResultNewData);
        }
    }else{
        [interceptorRemoteNotification didReceiveRemoteNotification:userInfo];
        
        completionHandler(UIBackgroundFetchResultNewData); 
    }
    
}

@end
