//
//  UIView+MBProgressHUD.m
//  LFMBProgressHUDDemo
//
//  Created by WangZhiWei on 16/5/26.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "LFUIView+MBProgressHUD.h"
#import "LFUIView+Add.h"
#import "LFNSString+Add.h"
#import "MBProgressHUD.h"
#import "LFUIImage+Resource.h"
#import "LFUIImage+Add.h"
#import <objc/runtime.h>

static const void *_showHudStatus = &_showHudStatus;

@implementation UIView (LFMBProgressHUDAdditions)

/*!
 @method
 @abstract
 @discussion	显示转菊花
 @param 	animated
 @result
 */
- (void)lf_showHUDAnimated:(BOOL)animated;
{
    [self lf_showHUDAnimated:animated yOffset:0 height:self.frame.size.height];

}

- (void)lf_showHUDAnimated:(BOOL)animated yOffset:(CGFloat)yOffset height:(CGFloat)height
{
    [self lf_removeAllHUDAnimated:animated];
    
    CGRect hudFrame = self.bounds;
    hudFrame.origin.y += yOffset;
    hudFrame.size.height = height;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:hudFrame];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    //hud.graceTime = 0.5; /// 延迟一小段时间再显示，能有更好的用户体验  //这里window不展示 homeTabBar也不展示
    [hud show:animated];
}




/*!
 @method
 @abstract
 @discussion	显示消息
 @param 	animated
 @param 	message 	消息内容
 @result
 */
- (void)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message;
{
    [self showTimedHUD:animated message:message hideAfter:1.2];

}

- (void)showTimedHUD:(BOOL)animated message:(NSString *)message hideAfter:(NSTimeInterval)time {
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return;
    
    //支持多行
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = message;
    label.numberOfLines = 20;
    CGSize size = [message lf_sizeForFont:label.font size:CGSizeMake(self.lf_width - 40, self.lf_height - 40) mode:label.lineBreakMode];
    label.lf_size = CGSizeMake(size.width + 1, size.height + 1);
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = label;
    hud.margin = 10.f;
    //    hud.yOffset = self.height > 480 ? 0 : -80;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:time];
}

/*!
 @method
 @abstract
 @discussion
 @param 	animated
 @param 	message 	消息内容
 @param 	time 	延迟时间
 @result
 */
- (MBProgressHUD *)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message dalayTime:(NSTimeInterval)time
{
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return nil;
    
    //支持多行
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = message;
    label.numberOfLines = 18;
    CGSize size = [message lf_sizeForFont:label.font size:CGSizeMake(CGRectGetWidth(self.bounds) - 60, CGRectGetHeight(self.bounds) - 40) mode:label.lineBreakMode];
    label.lf_size = CGSizeMake(size.width + 1, size.height + 1);
    UIView *v = [UIView new];
    v.lf_size = label.lf_size;
    v.lf_width += 15;
    v.lf_height += 15;
    [v addSubview:label];
    label.center = CGPointMake(v.lf_width / 2, v.lf_height / 2);
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = v;
    hud.margin = 10.f;
    hud.yOffset = CGRectGetHeight(self.bounds) > 480 ? 0 : -80;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:time];
    return hud;
}



- (void)popupMessage:(NSString*)message offsetY:(CGFloat)offsetY animated:(BOOL)animated {
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.cornerRadius = 2.5f;
    hud.margin = 10.f;
    hud.xOffset = 0;
    hud.yOffset = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    hud.yOffset = offsetY;
    
    [hud hide:animated afterDelay:2.0];
}

- (void)lf_showHUDAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    
    [self setShowHudStatus:YES];
    NSTimer *timer = [NSTimer timerWithTimeInterval:delay target:self selector:@selector(handleShowTimer:) userInfo:@(animated) repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)handleShowTimer:(NSTimer *)timer{
    
    if ([self showHudStatus]) {
        [self lf_showHUDAnimated:[timer.userInfo boolValue]];
    }
    
}

- (void)setShowHudStatus:(BOOL)status{
    
    objc_setAssociatedObject(self, _showHudStatus, @(status), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showHudStatus{
    
    if (objc_getAssociatedObject(self, _showHudStatus)) {
        return [objc_getAssociatedObject(self, _showHudStatus) boolValue];
    }
    return YES;
}


/*!
 @method
 @abstract
 @discussion  目前仅是利用MBProgressHUD自带属性，设置view，后期可自定义customeView
 @param     image
 @param 	animated
 @param 	message 	消息内容
 @param 	time 	延迟时间
 @result
 */
- (void)lf_showHUDMessage:(NSString *)message imageNamed:(NSString *)image animated:(BOOL)animated dalay:(NSTimeInterval)time
{
    [self lf_removeAllHUDAnimated:animated];
    if (message.length == 0) return;
    if (image == nil) return;
    
    //自定义图片
    
    //获取图片资源
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",filePath, @"skin_common.bundle"];
    UIImage *customeImage = [UIImage lf_imageForKey:image inBundle:[NSBundle bundleWithPath:bundlePath]];
    customeImage = [customeImage lf_imageByDecoded];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.square = YES;
    hud.customView = [[UIImageView alloc] initWithImage:customeImage];
    hud.labelText = message;;
    hud.labelFont = [UIFont boldSystemFontOfSize:10.0f];
    [hud show:animated];
    [hud hide:animated afterDelay:time];
}

/*!
 @method
 @abstract
 @discussion	删除
 @param 	animated
 @result
 */
- (void)lf_removeAllHUDAnimated:(BOOL)animated
{
    [self setShowHudStatus:NO];
    [MBProgressHUD hideAllHUDsForView:self animated:animated];
}

@end
