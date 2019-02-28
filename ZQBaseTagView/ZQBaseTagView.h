//
//  ZQBaseTagView.h
//  huazhu
//
//  Created by zhiqing on 2018/11/20.
//  Copyright © 2019 zhiqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQBaseTagViewModel.h"
#import "ZQCustomButton.h"

NS_ASSUME_NONNULL_BEGIN
// 初始化时 需要给默认frame   --- 只支持图片文字横向排列  不支持图片和title 上下排
@interface ZQBaseTagView : UIView

@property (nonatomic, assign) CGFloat  tagViewWidth; // 控件实际宽度 -- 初始化需要设置如果不设置则需要设置两次frame

@property (nonatomic, assign) CGFloat  itemSpace; // 控件间间距
@property (nonatomic, assign) CGFloat  rowSpace;  // 行间距
@property (nonatomic, assign) CGFloat  contentInset;  // 内容左右边距
@property (nonatomic, assign) CGFloat  itemHeight; // 单个条目的高度

@property (nonatomic, assign) CGFloat  cornerRadius; // 圆角
@property (nonatomic, strong) UIColor * borderColor;  // 边框颜色
@property (nonatomic, strong) UIColor * selectedBorderColor; // 选中边框颜色

@property (nonatomic, strong) UIColor * bgColor;   // 背景颜色
@property (nonatomic, strong) UIColor * selectedBgColor; // 选中背景颜色

@property (nonatomic, strong) UIColor * textColor;  // 文字颜色
@property (nonatomic, strong) UIColor * selectedTextColor; // 选中文字颜色

@property (nonatomic, strong) UIFont * textFont;   // 文字 字体
@property (nonatomic, strong) UIFont * selectedTextFont;   // 选中文字 字体

@property (nonatomic, strong) UIImage *titleImage;  // 标题图片
@property (nonatomic, strong) UIImage *selectedTitleImage;  // 选中标题图片
//@property (nonatomic, assign) CGFloat  imageWH;      // 标题图片宽高 
@property (nonatomic, assign) CGFloat  titleImageSpae; // 图片 文字间距
@property (nonatomic, assign) ZQCustomButtonType  buttonType; // 图片文字布局方式  --- 只支持图片文字横向排列  不支持图片和title 上下排
@property (nonatomic, assign) UIControlContentHorizontalAlignment contentHorizontalAlignment;  // 按钮 contentMode  仅支持 isAverage 均分模式

@property (nonatomic, strong) NSArray<ZQBaseTagViewModel *> *tagArray;
@property (nonatomic, assign) NSInteger secion;

@property (nonatomic, assign) BOOL  isMultiSelect;  // 是否支持多选

@property (nonatomic,copy) void (^tagViewClick)(NSInteger curentClickIndex); // 当前选中index
@property (nonatomic,copy) void (^tagViewClickNew)(NSInteger curentClickSection,NSInteger curentClickIndex,ZQCustomButton *btn); // 当前选中index

//isAverage和itemWidth同时设置才生效
@property (nonatomic, assign) BOOL isAverage;// 是否平均排列;
@property (nonatomic, assign) NSInteger itemColunm;//均分多少列;
@property (nonatomic, assign) NSInteger itemMinWidth;//isAverage 为NO时的最小宽度;

/**
 获取已经选中的数据

 @return 选中的数组
 */
- (NSArray *)getSelectDataArray;

/**
 获取均分tagview高度

 @param viewWidth tagView总宽度
 @param tagArray    数据源数组-- 调用之前处理好title数组
 @param itemSpace   横向item间距
 @param rowSpace    纵向行间距
 @param itemHeight  单行高度
 @param itemColunm  控件列数
 @param contentInset 内容边距
 @return  均分tagview高度
 */
+ (CGFloat)getAverageHeightWithviewWidth:(CGFloat)viewWidth
                                  tagArray:(NSArray *)tagArray
                                 itemSpace:(CGFloat)itemSpace
                                  rowSpace:(CGFloat)rowSpace
                                itemHeight:(CGFloat)itemHeight
                                itemColunm:(NSInteger)itemColunm
                              contentInset:(CGFloat)contentInset;


/**
 获取均分tagview高度
 
 @param viewWidth       tagView总宽度
 @param tagArray        数据源数组-- 调用之前处理好title数组
 @param itemSpace       横向item间距
 @param rowSpace        纵向行间距
 @param itemHeight      单行高度
 @param itemMinWidth    动态宽度 最小item宽度
 @param contentInset    内容边距
 @param titleImage      图片
 @param titleImageSpae  图片与文字宽度
 @param textFont        文字大小时需要传
 @return  均分tagview高度
 */
+ (CGFloat)getNoAverageHeightWithViewWidth:(CGFloat)viewWidth
                         tagArray:(NSArray *)tagArray
                        itemSpace:(CGFloat)itemSpace
                         rowSpace:(CGFloat)rowSpace
                       itemHeight:(CGFloat)itemHeight
                     itemMinWidth:(CGFloat)itemMinWidth
                     contentInset:(CGFloat)contentInset
                   titleImageSpae:(CGFloat)titleImageSpae
                       titleImage:(UIImage *)titleImage
                         textFont:(UIFont *)textFont;
/**
 获取控件高度
 
 @param viewWidth tagView总宽度
 @param tagArray 数据源数组  -- 调用之前处理好title数组
 @param itemSpace 横向item间距
 @param rowSpace 纵向行间距
 @param itemHeight   isAverage 为NO 时需要传
 @param itemColunm isAverage 为yYES 时需要传 如果平分情况 控件列数
 @param itemMinWidth isAverage 为NO 时需要传 动态宽度 最小item宽度
 @param contentInset 内容边距
 @param titleImage   isAverage 为NO 时需要传
 @param titleImageSpae isAverage 为NO 时需要传 图片与文字宽度
 @param textFont isAverage 为NO 时需要传
 
 @param isAverage 是否平分
 @return 控件高度
 */

+ (CGFloat)getHeightWithViewWidth:(CGFloat)viewWidth
                         tagArray:(NSArray *)tagArray
                        itemSpace:(CGFloat)itemSpace
                         rowSpace:(CGFloat)rowSpace
                       itemHeight:(CGFloat)itemHeight
                       itemColunm:(NSInteger)itemColunm
                     itemMinWidth:(CGFloat)itemMinWidth
                     contentInset:(CGFloat)contentInset
                   titleImageSpae:(CGFloat)titleImageSpae
                       titleImage:(UIImage *)titleImage
                         textFont:(UIFont *)textFont
                        isAverage:(BOOL)isAverage;


@end

NS_ASSUME_NONNULL_END
