 

#import "UILabel+DYScreenRatioAutoLayout.h"
#import "DYScreenRatioAutoLayoutConfig.h"
#import "UIView+DYScreenRatioAutoLayout.h"

#import <objc/runtime.h>

@interface UILabel (_DYScreenRatioAutoLayout)
@property (nonatomic, assign) CGFloat gj_originalFontSize;
@end

@implementation UILabel (_DYScreenRatioAutoLayout)

- (void)setGj_originalFontSize:(CGFloat)originalFontSize {
    objc_setAssociatedObject(self, @selector(gj_originalFontSize), @(originalFontSize), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)gj_originalFontSize {
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

@end

@implementation UILabel (DYScreenRatioAutoLayout)

+ (void)load {
    DYScreenRatioAutoLayoutExchangeImplementations(self, @selector(setPreferredMaxLayoutWidth:), @selector(gj_setPreferredMaxLayoutWidth:));
}

#pragma mark- aLRatio rewrite
- (void)setALRatio:(BOOL)aLRatio {
    if (self.gj_aLRatio == aLRatio) return;
    [super setALRatio:aLRatio];
    //reset only when changed
    [self resetFont];
    [self resetPreferredMaxLayoutWidth];
}


#pragma mark - preferredMaxLayoutWidth
//scaled when user set by code.
- (void)gj_setPreferredMaxLayoutWidth:(CGFloat)width {
    CGFloat maxWidth = width;
    if (self.gj_aLRatio && maxWidth > 0) {
        
        maxWidth = [DYScreenRatioAutoLayoutConfig fixWithScreenScale:maxWidth];
        
    }
    [self gj_setPreferredMaxLayoutWidth:maxWidth];
}

#pragma mark- private method
- (void)resetFont {
    if (self.gj_aLRatio) {
        self.gj_originalFontSize = self.font.pointSize;
        CGFloat size = floorl([DYScreenRatioAutoLayoutConfig fixWithScreenScale:self.font.pointSize]);
        NSString *name = self.font.fontName;
        self.font = [UIFont fontWithName:name size:size];
    }
    else {
        self.font = [UIFont fontWithName:self.font.fontName size:self.gj_originalFontSize];
    }
}

- (void)resetPreferredMaxLayoutWidth {
    if (self.gj_aLRatio && self.preferredMaxLayoutWidth > 0) {
        [self gj_setPreferredMaxLayoutWidth:[DYScreenRatioAutoLayoutConfig fixWithScreenScale:self.preferredMaxLayoutWidth]];
    }
}

@end
