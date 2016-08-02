//
//  UIBarButtonItem+Image.m
//  LaiFeng
//
//  Created by xinliu on 14-4-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import "LFUIBarButtonItem+Image.h"
#import "LFCategory.h"


@implementation UIBarButtonItem (LFCustomImageAdditions)




+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                          action:(SEL)selector {
    static UIImage * _navigationBarBg;
    if (!_navigationBarBg) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 44.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, LFUIColorWithRGBA(0, 0, 0, 0.2f).CGColor);
        CGContextFillRect(context, rect);
        _navigationBarBg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    static UIImage * _navigationBarBgHl;
    
    if (!_navigationBarBgHl) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 44.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, LFUIColorWithRGBA(0, 0, 0, 0.4f).CGColor);
        CGContextFillRect(context, rect);
        _navigationBarBgHl = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if([UIBarButtonItem isHigherIOS7]){
        return [UIBarButtonItem lf_rsBarButtonItemWithTitle:title
                                                      image:nil
                                           heightLightImage:_navigationBarBgHl
                                               disableImage:nil
                                                     target:target
                                                     action:selector];
    }else{
        return [UIBarButtonItem lf_rsBarButtonItemWithTitle:title
                                                      image:_navigationBarBg
                                           heightLightImage:_navigationBarBgHl
                                               disableImage:nil
                                                     target:target
                                                     action:selector];
    }
    
}

+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                           image:(UIImage *)image
                                heightLightImage:(UIImage *)hlImage
                                    disableImage:(UIImage *)disImage
                                          target:(id)target
                                          action:(SEL)selector {
    
    
    UIFont *font = nil;
    if (title.length <= 2) {
        font = [UIFont systemFontOfSize:15.0f];
    } else {
        font = [UIFont systemFontOfSize:13.0f];
    }
    UIButton* customButton = [self lf_rsCustomBarButtonWithTitle:title
                                                           image:image
                                                heightLightImage:hlImage
                                                    disableImage:disImage
                                                            font:font
                                                          target:target
                                                          action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && ![title isEqualToString:@""]) {
        sizeOfTitle = [title lf_sizeForFont:customButton.titleLabel.font size:CGSizeMake(100.0f, 22.0f) mode:NSLineBreakByTruncatingMiddle];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentImage != nil) {
        width = customButton.currentImage.size.width;
        height = customButton.currentImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+32.0f,
                                          height)];
    }
    
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30.f, 0, 0);
    customButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    
    
    UIBarButtonItem *barBtnItem  = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width             = customButton.lf_width;
    return barBtnItem;
}


+ (UIBarButtonItem *)lf_rsLeftBarButtonItemWithTitle:(NSString *)title
                                               image:(UIImage *)image
                                    heightLightImage:(UIImage *)hlImage
                                        disableImage:(UIImage *)disImage
                                                font:(UIFont *)font
                                              offset:(CGFloat)offset//调整tite左边距
                                              target:(id)target
                                              action:(SEL)selector {
    
    UIButton* customButton = [self lf_rsCustomBarButtonWithTitle:title
                                                           image:image
                                                heightLightImage:hlImage
                                                    disableImage:disImage
                                                            font:font
                                                          target:target
                                                          action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && ![title isEqualToString:@""]) {
        sizeOfTitle = [title lf_sizeForFont:customButton.titleLabel.font size:CGSizeMake(100.0f, 22.0f) mode:NSLineBreakByTruncatingMiddle];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentImage != nil) {
        width = customButton.currentImage.size.width;
        height = customButton.currentImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+32.0f,
                                          height)];
    }
    customButton.imageEdgeInsets = UIEdgeInsetsMake(0, 14.f, 0, -14.f);
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0, offset, 0, 0);
    customButton.titleLabel.font = font;
    UIBarButtonItem *barBtnItem  = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width             = customButton.lf_width;
    return barBtnItem;
}





+ (UIButton*)lf_rsCustomBarButtonWithTitle:(NSString*)title
                                     image:(UIImage *)image
                          heightLightImage:(UIImage *)hlImage
                              disableImage:(UIImage *)disImage
                                      font:(UIFont *)font
                                    target:(id)target
                                    action:(SEL)selector {
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image != nil) {
        [customButton setImage:image forState:UIControlStateNormal];
        [customButton setBackgroundColor:[UIColor clearColor]];
    }
    else {
        //        [customButton setBackgroundColor:[UIColor blueColor]];
    }
    if (hlImage != nil) {
        [customButton setImage:hlImage forState:UIControlStateHighlighted];
    }
    if (nil != disImage)
    {
        [customButton setImage:disImage forState:UIControlStateDisabled];
    }
 
    [customButton.titleLabel setFont:font];
    
    [customButton.titleLabel setShadowOffset:CGSizeMake(0.0f, 0.5f)];
    if (title!=nil && ![title isEqualToString:@""]) {
        [customButton setTitle:title forState:UIControlStateNormal];
        [customButton setTitleColor:LFUIColorWithHexRGB(0xffa000) forState:UIControlStateNormal];
        if (![UIBarButtonItem isHigherIOS7]) {
            [customButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
            [customButton setTitleShadowColor:LFUIColorWithRGBA(0, 0, 0, 0.4) forState:UIControlStateDisabled];
        }
    }
    [customButton setTitleColor:[LFUIColorWithHexRGB(0xffa000) colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return customButton;
}

+ (BOOL)isHigherIOS7 {
    
    NSString * requestSysVer = @"7.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] != NSOrderedAscending) {
        
        return YES;
    }
    
    return NO;
}

@end

