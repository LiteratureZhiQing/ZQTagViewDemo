//
//  ZQCustomButton.m
//
//  Created by zhiqing on 2018/12/28.
//  Copyright © 2018 zhiqing. All rights reserved.
//

#import "ZQCustomButton.h"

@interface ZQCustomButton ()

@end

@implementation ZQCustomButton

#pragma mark Layout Subview
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    if (self.frame.size.width<labelWidth) {
      //  self.titleLabel.intrinsicContentSize.width 取得是文本实际需要的宽度 如果按钮的宽度小于实际宽度 设置图片位置会有问题 所以添加这个限制
        labelWidth = self.frame.size.width-self.zq_spacing-imageWith;
    }
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //根据zqCustomButtonType和zq_spacing得到imageEdgeInsets和labelEdgeInsets的值
    switch (self.zq_buttonType) {
        case ZQCustomButtonImageTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - self.zq_spacing , 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - self.zq_spacing , 0);
            break;
        }
        case ZQCustomButtonImageLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.zq_spacing , 0, self.zq_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, self.zq_spacing , 0, -self.zq_spacing );
            break;
        }
        case ZQCustomButtonImageBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.zq_spacing , -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - self.zq_spacing , -imageWith, 0, 0);
            break;
        }
        case ZQCustomButtonImageRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + self.zq_spacing , 0, -labelWidth - self.zq_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - self.zq_spacing , 0, imageWith + self.zq_spacing );
            break;
        }
        case ZQCustomButtonImageLeftTopLabel:{
            imageEdgeInsets = UIEdgeInsetsMake(0, self.zq_spacing , 0, -self.zq_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(-10, self.zq_spacing , 10, -self.zq_spacing );
            break;
        }
        
        case ZQCustomButtonNoHaveImageLabel:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0 , 0, 0 );
            labelEdgeInsets = UIEdgeInsetsMake(0, 0 , 0, 0 );
            break;
        }
        default:
            break;
    }
    
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}


#pragma mark lazy loading
- (CGFloat)zq_spacing{
    if (!_zq_spacing) {
        _zq_spacing = 5;
    }
    return _zq_spacing * 0.5;
}

@end
