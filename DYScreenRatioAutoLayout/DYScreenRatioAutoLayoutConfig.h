 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void DYScreenRatioAutoLayoutExchangeImplementations(Class class, SEL newSelector, SEL oldSelector);


typedef NS_ENUM(NSUInteger, GJScreenSizeType) {
    GJScreenSizeTypeiPhone4or5,
    GJScreenSizeTypeiPhone6LikeThisScreen,
    GJScreenSizeTypeiPhone6PlusLikeThisScreen,
};

@interface DYScreenRatioAutoLayoutConfig : NSObject


+ (void)startWithScreenSizeType:(GJScreenSizeType)type;

+ (CGFloat)fixWithScreenScale:(CGFloat)value;

@end
