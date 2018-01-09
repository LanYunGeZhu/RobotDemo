//
//  XHDatePickerView.h
//  XHDatePicker
//
//  Created by 江欣华 on 16/8/16.
//  Copyright © 2016年 江欣华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassCurrentDateDelegate <NSObject>

-(void)passCurrentDate:(NSDate *)currentdate;

@end

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}XHDateStyle;


@interface XHDatePickerView : UIView

@property (nonatomic,strong) id <PassCurrentDateDelegate> dateDelegate;

@property (nonatomic,assign)XHDateStyle datePickerStyle;
@property (nonatomic,strong)UIColor *themeColor;

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期


-(instancetype)initWithCompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;

/**
 *   设置打开选择器时的默认时间，
 *   minLimitDate < currentDate < maxLimitDate  显示 currentDate;
 *   currentDate < minLimitDate ||  currentDate > maxLimitDate   显示minLimitDate;
 */
-(instancetype)initWithCurrentDate:(NSDate *)currentDate CompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;

-(void)show;


@end
