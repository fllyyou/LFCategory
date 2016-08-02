//
//  UIBarButtonItem+Image.h
//  LaiFeng
//
//  Created by xinliu on 14-4-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIBarButtonItem (LFCustomImageAdditions)


// 普通item
+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                          action:(SEL)selector;

// 目前一般作为导航栏rightIem使用
+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                           image:(UIImage *)image
                                heightLightImage:(UIImage *)hlImage
                                    disableImage:(UIImage *)disImage
                                          target:(id)target
                                          action:(SEL)selector;

// 主要作为导航栏leftItem
+ (UIBarButtonItem *)lf_rsLeftBarButtonItemWithTitle:(NSString *)title
                                               image:(UIImage *)image
                                    heightLightImage:(UIImage *)hlImage
                                        disableImage:(UIImage *)disImage
                                                font:(UIFont *)font
                                              offset:(CGFloat)offset//调整tite左边距
                                              target:(id)target
                                              action:(SEL)selector;

// 自定义一个button
+ (UIButton*)lf_rsCustomBarButtonWithTitle:(NSString*)title
                                     image:(UIImage *)image
                          heightLightImage:(UIImage *)hlImage
                              disableImage:(UIImage *)disImage
                                    target:(id)target
                                    action:(SEL)selector;




@end



