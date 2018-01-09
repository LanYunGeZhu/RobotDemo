//
//  BaseButton.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/17.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;//文字显示
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.font=[UIFont systemFontOfSize:15.0];
        self.backgroundColor = [UIColor clearColor];
        
//        [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//        [self setTitleColor:NavTabColor forState:(UIControlStateSelected)];
//        
//        [self setBackgroundImage: [self createImageWithColor:NavTabColor] forState:(UIControlStateNormal)];
//        [self setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:(UIControlStateSelected)];
        
    }
    return self;
}

- (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
