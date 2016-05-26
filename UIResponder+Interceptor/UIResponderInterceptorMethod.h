 
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIResponderInterceptorMethod : NSObject<UIApplicationDelegate>{
    
}
@property (nonatomic, weak) id<UIApplicationDelegate> replacerTarget;  //替换的目标
@property (nonatomic, weak) id<UIApplicationDelegate> originalTarget;  //原始目标

@end
