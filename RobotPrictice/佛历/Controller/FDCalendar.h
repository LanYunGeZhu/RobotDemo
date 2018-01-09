//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date;
@property (strong, nonatomic) NSDate *date;


@end
