//
//  UIView+MBProgressHUD.h
//  LFMBProgressHUDDemo
//
//  Created by WangZhiWei on 16/5/26.
//  Copyright © 2016年 youku. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface UIView (LFMBProgressHUDAdditions)


/*!
 	@method
 	@abstract   显示转菊花
 	@discussion
 	@param 	animated
 	@result
 */
- (void)lf_showHUDAnimated:(BOOL)animated;



/*!
 	@method
 	@abstract   提示框 默认1.2秒消失
 	@discussion
 	@param 	animated
 	@param 	message 	消息内容
 	@result
 */
- (void)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message;

/*!
 	@method
 	@abstract   可以设定时间的提示框
 	@discussion
 	@param 	animated
 	@param 	message 	消息内容
 	@param 	time 	延迟时间
 	@result
 */
- (MBProgressHUD *)lf_showHUDAnimated:(BOOL)animated message:(NSString *)message dalayTime:(NSTimeInterval)time;

/*!
 @method
 @abstract
 @discussion
 @param     image
 @param 	animated
 @param 	message 	消息内容
 @param 	time 	延迟时间
 @result
 */
- (void)lf_showHUDMessage:(NSString *)message imageNamed:(NSString *)image animated:(BOOL)animated dalay:(NSTimeInterval)time;


/*!
 	@method
 	@abstract
 	@discussion	删除
 	@param 	animated
 	@result
 */
- (void)lf_removeAllHUDAnimated:(BOOL)animated;





@end
