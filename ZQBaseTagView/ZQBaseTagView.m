//
//  ZQBaseTagView.m
//  huazhu
//
//  Created by zhiqing on 2018/11/20.
//  Copyright © 2018 zhenhua.shen. All rights reserved.
//

#import "ZQBaseTagView.h"
#import "NSString+string.h"
static NSInteger buttonStartTag = 1000;
static CGFloat ZQLineViewHeight = 1;
@interface ZQBaseTagView ()
@property (nonatomic, strong) ZQCustomButton *selectedBtn;

@end

@implementation ZQBaseTagView
- (instancetype )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagViewWidth = frame.size.width;
    }
    return self;
}
- (void)setTagArray:(NSArray *)tagArray{
    _tagArray = tagArray;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView * btn = self.subviews[i];
        [btn removeFromSuperview];
        btn = nil;
        i -= 1;
    }
    CGFloat buttonY = 0;
    CGFloat buttonX = 0;
    CGFloat buttonW = 0;
    CGFloat buttonH = self.itemHeight;
    NSAssert(self.tagViewWidth > 0, @"设置目标view宽度，否则高度计算不准确");
    CGFloat SurplusW = self.tagViewWidth;
    ZQCustomButton * lastRowButton;
    for (int i = 0; i < tagArray.count; i++) {
        ZQBaseTagViewModel *tagModel = tagArray[i];
        ZQCustomButton * button = [ZQCustomButton buttonWithType:UIButtonTypeCustom];
        button.tag = buttonStartTag + i;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, self.contentInset, 0, self.contentInset);
        [button setTitle:tagModel.title forState:UIControlStateNormal];
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
        button.titleLabel.font = self.textFont;
        button.backgroundColor = self.bgColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = self.cornerRadius;
        button.layer.borderColor = self.borderColor.CGColor;
        if (self.cornerRadius >0) {
            button.layer.borderWidth = ZQLineViewHeight;
        }

        if (tagModel.isSelected) {
            button.selected = YES;
            self.selectedBtn = button;
            [self changeBtnStatus:button];
        }

        button.clipsToBounds = YES;
        // 设置图片
        UIImage * tittleImage = self.titleImage;
        UIImage * selectedTitleImage = self.selectedTitleImage;
        if (tagModel.titleImage) {
            tittleImage = tagModel.titleImage;
        }
        if (tagModel.selectedTitleImage) {
            selectedTitleImage = tagModel.selectedTitleImage;
        }
        
        if (tittleImage) {
            [button setImage:tittleImage forState:UIControlStateNormal];
            [button setImage:selectedTitleImage forState:UIControlStateSelected];
            button.zq_spacing = self.titleImageSpae >0 ?self.titleImageSpae:10;
            button.zq_buttonType = self.buttonType;
        }else{
            // 没有图片的话 默认无图片
            button.zq_buttonType = ZQCustomButtonNoHaveImageLabel;
        }
        
        // 计算item宽度
        if (self.isAverage) {
            buttonW = (self.tagViewWidth -  (self.itemColunm - 1) * self.itemSpace) / self.itemColunm;
            NSInteger row = i/self.itemColunm;
            NSInteger column = i % self.itemColunm;
            
            if (column == 0) {
                buttonX = 0;
            }else{
                buttonX = column * (buttonW + self.itemSpace);
            }
            
            if (row == 0) {
                buttonY = 0;
            }else{
                buttonY = row *(self.itemHeight + self.rowSpace);
            }

            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//            button.contentMode = self.btnContentMode;
            button.contentHorizontalAlignment = self.contentHorizontalAlignment;

        }else{
            // 文字宽度 + 内容边距 + 图片宽度 + 图片文字间距
            buttonW = [tagModel.title widthWithFont:self.textFont constrainedToHeight:buttonH] + 2 * self.contentInset;
            if (tittleImage) {
                buttonW = buttonW + tittleImage.size.width + self.titleImageSpae;
            }
            // 如果设置了最小宽度，但是实际宽度没有最小宽度多，则使用最小宽度
            if (buttonW < self.itemMinWidth) {
                buttonW = self.itemMinWidth;
            }
            
            if (SurplusW < buttonW) {
                SurplusW = self.tagViewWidth;
                buttonX = 0;
                buttonY = lastRowButton.frame.origin.y + lastRowButton.frame.size.height + self.rowSpace;
            }
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            buttonX = buttonX + self.itemSpace + buttonW;
            SurplusW = SurplusW - self.itemSpace - buttonW;
        }
        
        [self addSubview:button];
        lastRowButton = button;

        if (i == tagArray.count - 1) {
            CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, button.frame.origin.y + button.frame.size.height);
            self.frame = rect;
        }
    }
}


- (void)buttonClick:(ZQCustomButton *)btn{
    btn.selected = !btn.selected;
    ZQBaseTagViewModel * model = self.tagArray[btn.tag - buttonStartTag];
    model.isSelected = btn.isSelected;
    [self changeBtnStatus:btn];
    if (_isMultiSelect) {
    }else{
        if (self.selectedBtn && self.selectedBtn != btn) {
            self.selectedBtn.selected = NO;
            ZQBaseTagViewModel * lastSelectedModel = self.tagArray[self.selectedBtn.tag - buttonStartTag];
            [self changeBtnStatus:self.selectedBtn];
            lastSelectedModel.isSelected = self.selectedBtn.selected;

        }
        self.selectedBtn = btn;
    }

    if (self.tagViewClick) {
        self.tagViewClick(btn.tag - buttonStartTag);
    }
    if (self.tagViewClickNew) {
        self.tagViewClickNew(self.secion, btn.tag - buttonStartTag,btn);
    }
}

- (void)changeBtnStatus:(ZQCustomButton *)btn{
    if (btn.selected) {
        btn.backgroundColor = self.selectedBgColor?:self.bgColor;
        btn.layer.borderWidth = ZQLineViewHeight;
        UIColor * borderColor = self.selectedBorderColor?:self.borderColor;
        btn.layer.borderColor = borderColor.CGColor;
        btn.titleLabel.font = self.selectedTextFont?:self.textFont;
    }else{
        btn.backgroundColor = self.bgColor;
        btn.layer.borderWidth = ZQLineViewHeight;
        btn.layer.borderColor = self.borderColor.CGColor;
        btn.titleLabel.font = self.textFont;
    }
}

- (NSArray *)getSelectDataArray{
    NSMutableArray * array = [NSMutableArray array];
    for (ZQBaseTagViewModel * model in self.tagArray) {
        if (model.isSelected) {
            [array addObject:model];
        }
    }
    return array;
}

+ (CGFloat)getAverageHeightWithviewWidth:(CGFloat)viewWidth
                                tagArray:(NSArray *)tagArray
                               itemSpace:(CGFloat)itemSpace
                                rowSpace:(CGFloat)rowSpace
                              itemHeight:(CGFloat)itemHeight
                              itemColunm:(NSInteger)itemColunm
                            contentInset:(CGFloat)contentInset{
    
   return [self getHeightWithViewWidth:viewWidth tagArray:tagArray itemSpace:itemSpace rowSpace:rowSpace itemHeight:itemHeight itemColunm:itemColunm itemMinWidth:0 contentInset:contentInset titleImageSpae:0 titleImage:nil textFont:nil isAverage:YES];
}


+ (CGFloat)getNoAverageHeightWithViewWidth:(CGFloat)viewWidth
                                  tagArray:(NSArray *)tagArray
                                 itemSpace:(CGFloat)itemSpace
                                  rowSpace:(CGFloat)rowSpace
                                itemHeight:(CGFloat)itemHeight
                              itemMinWidth:(CGFloat)itemMinWidth
                              contentInset:(CGFloat)contentInset
                            titleImageSpae:(CGFloat)titleImageSpae
                                titleImage:(UIImage *)titleImage
                                  textFont:(UIFont *)textFont{
    
    return [self getHeightWithViewWidth:viewWidth tagArray:tagArray itemSpace:itemSpace rowSpace:rowSpace itemHeight:itemHeight itemColunm:0 itemMinWidth:itemMinWidth contentInset:contentInset titleImageSpae:titleImageSpae titleImage:titleImage textFont:textFont isAverage:NO];
}

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
                        isAverage:(BOOL)isAverage{
    CGFloat height = 0;
    if (isAverage) { // 均分的情况
        NSInteger rowNum = 0;
        if (tagArray.count == 0) {
            height = 0;
        }else if (tagArray.count % itemColunm == 0){
            rowNum = tagArray.count/itemColunm;
        }else{
            rowNum = tagArray.count/itemColunm + 1;
        }
        height = rowNum * itemHeight + (rowNum -1) *rowSpace;
        
    }else{
        CGFloat buttonW = 0;
        // 一行剩余的宽度
        CGFloat SurplusW = viewWidth;
        for (int i = 0 ; i < tagArray.count ; i++) {
            ZQBaseTagViewModel * tagModel = tagArray[i];
            // 文字宽度 + 内容边距 + 图片宽度 + 图片文字间距
            buttonW = [tagModel.title widthWithFont:textFont constrainedToHeight:itemHeight] + 2 * contentInset;
            
            UIImage * image = titleImage;
            if (tagModel.titleImage) {
                image = tagModel.titleImage;
            }
            
            if (image) {
                buttonW = buttonW + image.size.width + titleImageSpae;
            }
            // 如果设置了最小宽度，但是实际宽度没有最小宽度多，则使用最小宽度
            if (buttonW < itemMinWidth) {
                buttonW = itemMinWidth;
            }
            
            // 如果剩余的宽度 小于
            if (SurplusW < buttonW) {
                SurplusW = viewWidth;
                height += itemHeight + rowSpace;
            }
            SurplusW = SurplusW - itemSpace - buttonW;
           
            if (i == tagArray.count - 1) {
               height += itemHeight;
            }
        }
        
    }
    
    return height;
}

@end
