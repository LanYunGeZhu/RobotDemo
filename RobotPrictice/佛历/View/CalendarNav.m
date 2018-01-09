//
//  CalendarNav.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "CalendarNav.h"

@implementation CalendarNav

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 20, 35)];
        imageview.image = ImgName(@"佛历日期");
        [self addSubview:imageview];
        
        _yearLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 100, 15)];
        [self addSubview:_yearLab];
        _yearLab.textColor = [UIColor whiteColor];
        _yearLab.font = [UIFont systemFontOfSize:12];
        
        _monthLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 20, 100, 15)];
        [self addSubview:_monthLab];
        _monthLab.textColor = [UIColor whiteColor];
        _monthLab.font = [UIFont systemFontOfSize:14];
        
    }
    
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
