//
//  UIImage+LXCustom.h 
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomUserExt)

//通过颜色生存图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;


//改变图片颜色
- (UIImage *) imageWithTintColor:(UIColor *) tintColor;
- (UIImage *) imageWithTintColor:(UIColor *)tintColor andSize:(CGSize)size;

- (UIImage *) imageWithAlpha:(CGFloat) alpha;

//毛玻璃效果
- (UIImage*) blur:(CGFloat)inputRadius;

@end