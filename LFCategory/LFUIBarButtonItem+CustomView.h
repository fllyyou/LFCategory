//
//  LFUIBarButtonItem+CustomView.h
//
//
//  Created by guoliyuan on 16-10-20.
//  Copyright (c) 2016 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 自定义item 用于统一定制导航栏左右item
 */
@interface UIBarButtonItem (LFAdditions)


/**
 * 添加回调事件
 * 这里item默认是定义属性customview（uibutton）实际是给customview（uibutton）添加回调
 */
- (void)lf_setAction:(UIControlEvents)controlEvents block:(void (^)(id sender))block ;

/**
 * 添加多个回调
 */
- (void)lf_addActionEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 Remove all action block.
 */
- (void)lf_removeAllActionBlocks;



/**
 *  leftItem 或者 rightitem
 */
typedef NS_ENUM(NSInteger, LFCustomItemPosition) {
    
    LFCustomItemPositionLeft,
    LFCustomItemPositionRight,
};


// 只设置title
+ (instancetype )lf_barButtonItemWithTitle:(NSString *)title
                                      font:(UIFont *)font
                                     color:(UIColor *)color
                          highlightedColor:(UIColor *)hColor
                             disabledColor:(UIColor *)dColor
                                    margin:(CGFloat)margin//title距离左边或右边屏幕距离（作为左item时候title距离屏幕左边距为0；右item时 距距离屏幕右边距为0）
                                 darkAlpha:(CGFloat)alpha//按钮高亮时刻的变暗效果
                                    target:(id)target
                                    action:(SEL)selector
                                  position:(LFCustomItemPosition)position;

// 只设置image
+ (instancetype )lf_BarButtonItemWithImage:(UIImage *)image
                          heightLightImage:(UIImage *)hlImage
                                    margin:(CGFloat)margin//title距离左边或右边屏幕距离（作为左item时候title距离屏幕左边距为0；右item时 距距离屏幕右边距为0）
                                 darkAlpha:(CGFloat)alpha//按钮高亮时刻的变暗效果
                                    target:(id)target
                                    action:(SEL)selector
                                  position:(LFCustomItemPosition)position;



/**
 *  没有定义customview情况下调用此方法 否则不能成功回调
 */
@property (nonatomic, copy) void (^actionBlock)(id);



@end
