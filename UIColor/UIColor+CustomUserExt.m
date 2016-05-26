 

#import "UIColor+CustomUserExt.h"

@implementation UIColor (CustomUserExt)

- (UIColor *)lighterColor {
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:hue saturation:saturation brightness:MIN(brightness * 1.1, 1.0) alpha:alpha];
    }
    return nil;
}

- (UIColor *)darkerColor {
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.90 alpha:alpha];
    }
    return nil;
}

+(UIColor *)colorFromRGB:(unsigned long)rgbValue{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}
 

@end
