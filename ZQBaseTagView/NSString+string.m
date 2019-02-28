//
//  NSString+stringHeight.m
//  ZQTagViewDemo
//
//  Created by zhiqing on 2019/2/27.
//  Copyright © 2019 zhiqing. All rights reserved.
//

#import "NSString+string.h"

@implementation NSString (string)

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraph
                                 };
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
    
    return ceil(textSize.width);
}
@end
