//
//  ViewTool.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/23.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ViewTool.h"

@implementation ViewTool

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:15];
        [self addSubview:_label];
        
//        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
//        line1.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-0.5, 10, 0.5, self.frame.size.height - 20)];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        
        _lineLab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1)];
        _lineLab.backgroundColor = [UIColor clearColor];
        [self addSubview:_lineLab];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    NSLog(@"wertytrewrtyutr");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
