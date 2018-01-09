//
//  UIView+Extension.h
 
//
//  Created by susu on 15-3-13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

//分类,只能扩充方法,不能扩充成员变量
@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat width ;

@property (nonatomic,assign) CGFloat height ;

@property (nonatomic,assign) CGSize  size;

/** 扩充的属性 */
//@property (nonatomic,assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property(nonatomic,assign) CGFloat bottom;

@end
