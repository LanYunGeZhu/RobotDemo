//
//  JCProgressHUD.h
//
//  Created by Jacob Chiang on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//弹出框
#import <UIKit/UIKit.h>
//#import <AvailabilityMacros.h>

enum {
    JCProgressHUDMaskTypeNone = 1,
    JCProgressHUDMaskTypeClear,
    JCProgressHUDMaskTypeBlack,
    JCProgressHUDMaskTypeGradient
};

typedef NSUInteger JCProgressHUDMaskType;

@interface JCProgressHUD : UIView

#pragma mark--可以使用以下方法来显示状态
+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(JCProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(JCProgressHUDMaskType)maskType;

#pragma mark--以下方法用来显示状态，并在1秒后自动隐藏
+ (void)showSuccessWithStatus:(NSString *)string;//1秒后隐藏
+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration;//持续时间（自己设置持续时间）



+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration;

#pragma mark--
+ (void)setStatus:(NSString *)string;

#pragma mark--通过dismiss方法来隐藏提示
+ (void)dismiss;
+ (void)dismissWithSuccess:(NSString *)successString;
+ (void)dismissWithSuccess:(NSString *)successString afterDelay:(NSTimeInterval)seconds;//延迟多少秒隐藏
+ (void)dismissWithError:(NSString *)errorString;
+ (void)dismissWithError:(NSString *)errorString afterDelay:(NSTimeInterval)seconds;

#pragma mark--
+ (BOOL)isVisible;//是否可见

#pragma mark--
+ (void)showWithStatus:(NSString *)status networkIndicator:(BOOL)show DEPRECATED_ATTRIBUTE;
+ (void)showWithStatus:(NSString *)status maskType:(JCProgressHUDMaskType)maskType networkIndicator:(BOOL)show DEPRECATED_ATTRIBUTE; 
+ (void)showWithMaskType:(JCProgressHUDMaskType)maskType networkIndicator:(BOOL)show DEPRECATED_ATTRIBUTE;



@end