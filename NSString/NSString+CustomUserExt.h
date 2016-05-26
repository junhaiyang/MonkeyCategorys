 

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NSString(CustomUserExt)

-(CGSize)sizeToFit:(CGSize)size fontSize:(CGFloat)fontSize;
-(CGSize)sizeToFit:(CGSize)size fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace;

@end
