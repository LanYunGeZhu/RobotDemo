//
//  UIView+Extension.m
 
//
//  Created by susu on 15-3-13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/**
 * 当前的view的基础上,设置frame的x
 */
-(void)setX:(CGFloat)x
{
    /*
     CGRect textF = self.textLabel.frame ;
     textF.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
     self.textLabel.frame = textF;
     */

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


/**
 * 当前的view的基础上,设置frame的y
 */
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y
{
  return self.frame.origin.y;
}




-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}


-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}

/** 
  尺寸的设置
 */
-(void)setSize:(CGSize)size
{
    //方式1.
    CGRect frame =  self.frame ;  //ok
   // CGRect frame = self.bounds;//也ok
    frame.size = size;
    self.frame = frame;
    //方式2.
    /*
    self.width = size.width; //会进入上面的setWitdth方法
    self.height = size.height;*/
}


/** 起始点的设置 */
-(void)setOrigin:(CGPoint)origin
{
    //方式1.
    CGRect frame =  self.frame ;  //ok
   
    frame.origin = origin;
    self.frame = frame;
    
    //方式2.
    /*
     self.x = origin; //会进入上面的setWitdth方法
     self.y =  origin ; */
}

-(CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
