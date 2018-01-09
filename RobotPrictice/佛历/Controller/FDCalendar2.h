//
//  FDCalendar2.h
//  Calendar_SF
//
//  Created by SongFeng on 17/3/28.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDCalendar2 : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date;
@property (strong, nonatomic) NSDate *date;

@end
