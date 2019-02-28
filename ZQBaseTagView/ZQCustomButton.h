//
//  YSLCustomButton.h
//  YSLFramework
//
//  Created by lvyue on 2017/12/28.
//  Copyright © 2017年 lvyue. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,ZQCustomButtonType) {
    ZQCustomButtonImageTop    = 0 , //图片在上边
    ZQCustomButtonImageLeft   = 1 , //图片在左边
    ZQCustomButtonImageBottom = 2 , //图片在下边
    ZQCustomButtonImageRight = 3,  //图片在右边
    ZQCustomButtonImageLeftTopLabel  = 4,   //图片在左边 文字右上角
    ZQCustomButtonNoHaveImageLabel  = 5   //无图片

};

@interface ZQCustomButton : UIButton

/** 图片和文字间距 默认10px*/
@property (nonatomic , assign) CGFloat zq_spacing;

/** 按钮类型 默认YSLCustomButtonImageTop 图片在上边*/
@property (nonatomic , assign) ZQCustomButtonType zq_buttonType;


@end
