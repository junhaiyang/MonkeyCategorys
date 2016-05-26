

#import "NSString+CustomUserExt.h"

@implementation NSString(CustomUserExt)


-(CGSize)sizeToFit:(CGSize)size fontSize:(CGFloat)fontSize{
    UILabel *label =[[UILabel alloc] init];
    label.font =[UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.text = self;
    label.frame= CGRectMake(0, 0,size.width,size.height);
    [label sizeToFit];
    return label.frame.size;
}
-(CGSize)sizeToFit:(CGSize)size fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace{
    
    UILabel *label =[[UILabel alloc] init];
    label.font =[UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    NSString *string = self;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    label.attributedText = attributedString;
    
    label.frame= CGRectMake(0, 0,size.width,size.height);
    [label sizeToFit];
    return label.frame.size;
}

@end
