 
#import "UIInterceptorRemoteNotification.h"
#import "UIResponderInterceptorMethod.h"
 
@interface UIInterceptorRemoteNotification(){

    
//    NSObject *lock;
    
    NSMutableArray *messages;
    
    NSRecursiveLock *lock;

}

@property (nonatomic,assign) BOOL executeImmediately;

@end

@implementation UIInterceptorRemoteNotification
@synthesize interceptorMethod;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        lock = [NSObject new];
        lock = [NSRecursiveLock new];
        messages =[NSMutableArray new];
        self.executeImmediately = YES;
    }
    return self;
}

-(void)willChangeApplicationState:(UIApplicationState)applicationState{
    //是否改变状态

}

-(void)delayReceiveRemoteNotification{
    self.executeImmediately = NO;
}

-(void)activateRemoteNotification{
    
    [lock lock];
    
//    @synchronized (lock) {
        self.executeImmediately = YES;
        //TODO 如果有缓存全部释放
        for (NSDictionary *userInfo in messages) {
            void (^completionHandler)(UIBackgroundFetchResult);
            
            if([interceptorMethod.originalTarget respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]){
                [interceptorMethod.originalTarget application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
            }
        }
        [messages removeAllObjects];
//    }
    
    [lock unlock];
    
    
}

-(BOOL)willExecuteImmediately{
    return self.executeImmediately;
}
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [lock lock];
    
//    @synchronized (lock) {
        if(self.executeImmediately){
            void (^completionHandler)(UIBackgroundFetchResult);
            if([interceptorMethod.originalTarget respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]){
                [interceptorMethod.originalTarget application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
            }
        }else{
            [messages addObject:userInfo];
        }
//    }
    [lock unlock];

}

@end
