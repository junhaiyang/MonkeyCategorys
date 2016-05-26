 
#import "UIResponderInterceptorMethod.h"

@implementation UIResponderInterceptorMethod
 
@synthesize replacerTarget;
@synthesize originalTarget;

//优先跳转到替换的目标，再试原始目标
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([replacerTarget respondsToSelector:aSelector]) { return replacerTarget; }
    if ([originalTarget respondsToSelector:aSelector]) { return originalTarget; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([replacerTarget respondsToSelector:aSelector]) {
        return YES;
    }
    if ([originalTarget respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}
 

@end
