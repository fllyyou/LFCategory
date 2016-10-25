//
//  LFUIBarButtonItem+CustomView.m
//
//
//  Created by guoliyuan on 16-10-20.
//  Copyright (c) 2016 live Interactive. All rights reserved.
//

#import "LFUIBarButtonItem+CustomView.h"
#import "LFCategoryMacro.h"
#import <objc/runtime.h>
#import "LFUIControl+Add.h"
#import "LFUIColor+Add.h"
#import "LFUIImage+Add.h"
#import "LFNSString+Add.h"


static const int block_key;

@interface _LFUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _LFUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end

static float const customBarButtonWidth = 44.f;
static float const customBarButtonHeight = 44.f;


@implementation UIBarButtonItem (LFAdditions)



- (void)setActionBlock:(void (^)(id sender))block {
    _LFUIBarButtonItemBlockTarget *target = [[_LFUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    _LFUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}



- (void)lf_setAction:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    
    UIControl *customControl = nil;
    for (UIControl *v in self.customView.subviews) {
        if ([v isKindOfClass:[UIControl class]]) {
            customControl = v;
            break;
        }
    }
    
    if (customControl) {
        [customControl lf_setBlockForControlEvents:controlEvents block:block];
    }
    
}


- (void)lf_addActionEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    
    [self.customView lf_addBlockForControlEvents:controlEvents block:block];
    
}

- (void)lf_removeAllActionBlocks{
    
    [self.customView lf_removeAllTargets];
    
}



// 只设置title
+ (instancetype )lf_barButtonItemWithTitle:(NSString *)title
                                      font:(UIFont *)font
                                     color:(UIColor *)color
                          highlightedColor:(UIColor *)hColor
                             disabledColor:(UIColor *)dColor
                                    margin:(CGFloat)margin
                                 darkAlpha:(CGFloat)alpha
                                    target:(id)target
                                    action:(SEL)selector
                                  position:(LFCustomItemPosition)position {
    
    
    UIButton *customBtn = [self lf_CustomBarButtonWithTitle:title
                                                       font:font
                                                      color:color
                                           highlightedColor:hColor
                                              disabledColor:dColor
                                                      image:nil
                                           heightLightImage:nil
                                                     margin:margin
                                                  darkAlpha:alpha
                                                     target:target
                                                     action:selector
                                                   position:position];
    
    // 控制点击区域在button中（UIBarButtonItem 会默认扩大点击区域）
    UIView *bgView = [[UIView alloc] initWithFrame:customBtn.frame];
    [bgView addSubview:customBtn];
    return [[UIBarButtonItem alloc] initWithCustomView:bgView];
    
}

// 只设置image
+ (instancetype )lf_BarButtonItemWithImage:(UIImage *)image
                          heightLightImage:(UIImage *)hlImage
                                    margin:(CGFloat)margin
                                 darkAlpha:(CGFloat)alpha
                                    target:(id)target
                                    action:(SEL)selector
                                  position:(LFCustomItemPosition)position {
    
    UIButton *customBtn = [self lf_CustomBarButtonWithTitle:nil
                                                       font:nil
                                                      color:nil
                                           highlightedColor:nil
                                              disabledColor:nil
                                                      image:image
                                           heightLightImage:hlImage
                                                     margin:margin
                                                  darkAlpha:alpha
                                                     target:target
                                                     action:selector
                                                   position:position];
    
    // 控制点击区域在button中（UIBarButtonItem 会默认扩大点击区域）
    UIView *bgView = [[UIView alloc] initWithFrame:customBtn.frame];
    [bgView addSubview:customBtn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:bgView];
    
}


+ (UIButton*)lf_CustomBarButtonWithTitle:(NSString*)title
                                    font:(UIFont *)font
                                   color:(UIColor *)color
                        highlightedColor:(UIColor *)hColor
                           disabledColor:(UIColor *)dColor
                                   image:(UIImage *)image
                        heightLightImage:(UIImage *)hlImage
                                  margin:(CGFloat)margin
                               darkAlpha:(CGFloat)alpha
                                  target:(id)target
                                  action:(SEL)selector
                                position:(LFCustomItemPosition)position {
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:title forState:UIControlStateNormal];
    customButton.titleLabel.font = font ? font : [UIFont systemFontOfSize:16.f];
    color = color ? color : LFUIColorWithHexRGB(0xffa000);
    [customButton setTitleColor:color forState:UIControlStateNormal];
    [customButton setTitleColor:[color colorWithAlphaComponent:alpha] forState:UIControlStateHighlighted];
    if (hColor) {
        [customButton setTitleColor:hColor forState:UIControlStateHighlighted];
    }
    if (dColor) {
        [customButton setTitleColor:dColor forState:UIControlStateDisabled];
    }
    
    if (image) {
        [customButton setImage:image forState:UIControlStateNormal];
    }
    if (hlImage) {
        [customButton setImage:hlImage forState:UIControlStateHighlighted];
    } else {
        [customButton setImage:[image darkenImageAlpha:alpha] forState:UIControlStateHighlighted];
    }
    
    [customButton setFrame:CGRectMake(0, 0, customBarButtonWidth, customBarButtonHeight)];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && ![title isEqualToString:@""]) {
        sizeOfTitle = [title lf_sizeForFont:customButton.titleLabel.font size:CGSizeMake(100.0f, 22.0f) mode:NSLineBreakByTruncatingMiddle];
        
        if (sizeOfTitle.width <= customBarButtonWidth) {
            [customButton setFrame:CGRectMake(0, 0, customBarButtonWidth + margin, customBarButtonHeight)];
        } else {
            [customButton setFrame:CGRectMake(0, 0, sizeOfTitle.width + margin, customBarButtonHeight)];
        }
        
        if (position == LFCustomItemPositionLeft) {
            [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, margin, 0, 0)];
        } else {
            [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, margin)];
        }

    }
    
    
    if (image) {
        
        if (image.size.width  <= customBarButtonWidth ) {
            [customButton setFrame:CGRectMake(0, 0, customBarButtonWidth, customBarButtonHeight)];
        } else {
            [customButton setFrame:CGRectMake(0, 0, image.size.width + margin, customBarButtonHeight)];
        }

        if (position == LFCustomItemPositionLeft) {
            [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [customButton setImageEdgeInsets:UIEdgeInsetsMake(0, margin, 0, 0)];
        } else {
            [customButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [customButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, margin)];
        }
        
    }
    
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    return customButton;
}





@end
