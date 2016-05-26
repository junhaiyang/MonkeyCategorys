//
//  UIColor+Extras.h
//  ohmybaby
//
//  Created by yangjunhai on 13-11-26.
//  Copyright (c) 2013年 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define __RGBA(__rgb, __a) [UIColor colorWithRed:((float)((__rgb & 0xFF0000) >> 16))/255.0 green:((float)((__rgb & 0xFF00) >> 8))/255.0 blue:((float)(__rgb & 0xFF))/255.0 alpha:__a]

@interface UIColor (CustomUserExt)

- (UIColor *)lighterColor;

- (UIColor *)darkerColor;
 
+(UIColor *)colorFromRGB:(unsigned long)rgbValue;

@end
