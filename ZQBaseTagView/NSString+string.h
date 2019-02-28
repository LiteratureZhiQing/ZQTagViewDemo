//
//  NSString+string.h
//  ZQTagViewDemo
//
//  Created by zhiqing on 2019/2/27.
//  Copyright © 2019 zhiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (string)
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
