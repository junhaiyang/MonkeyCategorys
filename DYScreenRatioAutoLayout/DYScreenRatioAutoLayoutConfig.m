 

#import "DYScreenRatioAutoLayoutConfig.h"
#import <objc/runtime.h>


void DYScreenRatioAutoLayoutExchangeImplementations(Class class, SEL newSelector, SEL oldSelector) {
    Method oldMethod = class_getInstanceMethod(class, newSelector);
    Method newMethod = class_getInstanceMethod(class, oldSelector);
    method_exchangeImplementations(oldMethod, newMethod);
};
static GJScreenSizeType screenSizeType = GJScreenSizeTypeiPhone4or5;
static CGFloat screenScale = 0.0;

@implementation DYScreenRatioAutoLayoutConfig

+(void)load{
    screenScale =  [UIScreen mainScreen].bounds.size.width/[DYScreenRatioAutoLayoutConfig getScreenSizeWidth];
}

+ (void)startWithScreenSizeType:(GJScreenSizeType)type {
    screenSizeType = type;
    
    screenScale =  [UIScreen mainScreen].bounds.size.width/[DYScreenRatioAutoLayoutConfig getScreenSizeWidth];
}

+ (GJScreenSizeType)getScreenSizeType {
    return screenSizeType;
}

+ (NSInteger)getScreenSizeWidth {
    switch (screenSizeType) {
        case GJScreenSizeTypeiPhone4or5:
            return 320;
            break;
        case GJScreenSizeTypeiPhone6LikeThisScreen:
            return 375;
        case GJScreenSizeTypeiPhone6PlusLikeThisScreen:
            return 414;
        default:
            break;
    }
    return 320;
}
+ (CGFloat)fixWithScreenScale:(CGFloat)value{
    return  screenScale*value;
    
}

@end
