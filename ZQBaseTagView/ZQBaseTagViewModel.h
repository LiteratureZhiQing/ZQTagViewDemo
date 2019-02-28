//
//  ZQBaseTagViewModel.h
//
//  Created by zhiqing on 2019/1/28.
//  Copyright © 2019 zhiqing. All rights reserved.

//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQBaseTagViewModel : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL  isSelected;
@property (nonatomic, strong) UIImage *titleImage;  // 标题图片
@property (nonatomic, strong) UIImage *selectedTitleImage;  // 选中标题图片

@end

NS_ASSUME_NONNULL_END
