 

#import "UIView+DYScreenRatioAutoLayout.h"
#import "DYScreenRatioAutoLayoutConfig.h" 
#import <objc/runtime.h>


#pragma mark - NSLayoutConstaint Category

@interface NSLayoutConstraint (_DYScreenRatioAutoLayout)

/**
 *  gj_isRatio mark the constant is origin or scaled.
 */
@property (nonatomic, assign) BOOL gj_isRatio;

@end

@implementation NSLayoutConstraint (_DYScreenRatioAutoLayout)

+ (void)load {
    DYScreenRatioAutoLayoutExchangeImplementations(self, @selector(gj_constant), @selector(constant));
     
}

- (CGFloat)gj_constant {
    CGFloat constant = [self gj_constant];
    if (self.gj_isRatio) {
        constant = [DYScreenRatioAutoLayoutConfig fixWithScreenScale:constant];
    }
    return constant;
}

- (void)setGj_isRatio:(BOOL)gj_isRatio {
    if (self.gj_isRatio == gj_isRatio) return;
    objc_setAssociatedObject(self, @selector(gj_isRatio), @(gj_isRatio), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)gj_isRatio {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end


#pragma mark - UiView Category

@implementation UIView (DYScreenRatioAutoLayout)

+ (void)load {
    DYScreenRatioAutoLayoutExchangeImplementations(self, @selector(addConstraint:), @selector(gj_AddConstraint:));
}

- (BOOL)gj_aLRatio {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setGj_aLRatio:(BOOL)aLRatio {
    objc_setAssociatedObject(self, @selector(gj_aLRatio), @(aLRatio), OBJC_ASSOCIATION_RETAIN);
}

/**
 *  set aLRatio
 */
- (void)setALRatio:(BOOL)aLRatio {
    if (self.gj_aLRatio == aLRatio) return;
    self.gj_aLRatio = aLRatio;
    
    if (self.gj_aLRatio) {
        //if state is on, set all constraints constant scale
        for (NSLayoutConstraint * constraint in [self.gj_constraints allObjects]) {
            if (!constraint.gj_isRatio) {
                constraint.gj_isRatio = YES;
            }
        }
    }
}

/**
 *  gj_constraints is a hash table that collect constraints himself
 *
 *  @return hash table, week array.
 */
- (NSHashTable *)gj_constraints {
    NSHashTable *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN);
    }
    return array;
}


- (void)gj_AddConstraint:(NSLayoutConstraint *)constraint {
    
    if ([constraint isMemberOfClass:NSClassFromString(@"NSContentSizeLayoutConstraint")] &&
        ([self isKindOfClass:[UILabel class]] ||
         [self isKindOfClass:[UISlider class]] ||
         [self isKindOfClass:[UISwitch class]] ||
         [self isKindOfClass:[UIActivityIndicatorView class]] ||
         [self isKindOfClass:[UIPageControl class]] || 
         ([self isKindOfClass:[UIProgressView class]] &&
          constraint.firstAttribute == NSLayoutAttributeHeight))) {
             [self gj_AddConstraint:constraint];
             return;
         }
    
    if ([constraint isMemberOfClass:[NSLayoutConstraint class]] ||
        [constraint isMemberOfClass:NSClassFromString(@"MASLayoutConstraint")] ||
        [constraint isMemberOfClass:NSClassFromString(@"NSIBPrototypingLayoutConstraint")] ||
        [constraint isMemberOfClass:NSClassFromString(@"NSContentSizeLayoutConstraint")]) {
        
        //如果两个item有一个open，则这个constraint也open
        if ([self checkALRatioWithFirstItem:constraint.firstItem
                                 secondItem:constraint.secondItem]) {
            if (!constraint.gj_isRatio) {
                constraint.gj_isRatio = YES;
            }
        }
        
        //set item's constraints
        if (constraint.firstItem &&
            [constraint.firstItem isKindOfClass:[UIView class]]) {
            [((UIView *)constraint.firstItem).gj_constraints addObject:constraint];
        }
        
        if (constraint.secondItem &&
            [constraint.secondItem isKindOfClass:[UIView class]]) {
            [((UIView *)constraint.secondItem).gj_constraints addObject:constraint];
        }
    }
    
    [self gj_AddConstraint:constraint];
}

- (BOOL)checkALRatioWithFirstItem:(id)firstItem
                       secondItem:(id)secondItem {
    BOOL firstRatio = NO;
    if (firstItem && [firstItem isKindOfClass:[UIView class]]) {
        UIView *firstView = firstItem;
        firstRatio = firstView.gj_aLRatio;
    }
    
    BOOL secondRatio = NO;
    if (secondItem && [secondItem isKindOfClass:[UIView class]]) {
        UIView *secondView = secondItem;
        secondRatio = secondView.gj_aLRatio;
    }
    
    return firstRatio || secondRatio;
}

@end
