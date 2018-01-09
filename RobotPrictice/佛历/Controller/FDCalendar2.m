//
//  FDCalendar2.m
//  Calendar_SF
//
//  Created by SongFeng on 17/3/28.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "FDCalendar2.h"
#import "FDCalendarItem2.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]

static NSDateFormatter *dateFormattor;

@interface FDCalendar2 ()<UIScrollViewDelegate, FDCalendarItem2Delegate>


//@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDCalendarItem2 *leftCalendarItem;
@property (strong, nonatomic) FDCalendarItem2 *centerCalendarItem;
@property (strong, nonatomic) FDCalendarItem2 *rightCalendarItem;

@end


@implementation FDCalendar2

- (instancetype)initWithCurrentDate:(NSDate *)date{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.date = date;
        
//        [self setupTitleBar];
//        [self setupWeekHeader];
        [self setupCalendarItems];
        [self setupScrollView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, CGRectGetMaxY(self.scrollView.frame)+8)];
        
        [self setCurrentDate:self.date];
        
    }
    return self;
}

#pragma mark - Private
- (NSString *)stringFromDate:(NSDate *)date {
    if (!dateFormattor) {
        dateFormattor = [[NSDateFormatter alloc] init];
        [dateFormattor setDateFormat:@"MM-yyyy"];
    }
    return [dateFormattor stringFromDate:date];
}

//// 设置上层的titleBar
//- (void)setupTitleBar {
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 44)];
//    titleView.backgroundColor = [UIColor redColor];
//    [self addSubview:titleView];
//    
//    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    titleButton.titleLabel.textColor = [UIColor whiteColor];
//    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    titleButton.center = titleView.center;
//    [titleView addSubview:titleButton];
//    self.titleButton = titleButton;
//}

//// 设置星期文字的显示
//- (void)setupWeekHeader {
//    NSInteger count = [Weekdays count];
//    CGFloat offsetX = 5;
//    for (int i = 0; i < count; i++) {
//        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 10, (DeviceWidth - 10) / count, 20)];
//        weekdayLabel.textAlignment = NSTextAlignmentCenter;
//        weekdayLabel.text = Weekdays[i];
//        
//        if (i == 0 || i == count - 1) {
//            weekdayLabel.textColor = NavTabColor;
//        } else {
//            weekdayLabel.textColor = [UIColor blackColor];
//        }
//        
//        [self addSubview:weekdayLabel];
//        offsetX += weekdayLabel.frame.size.width;
//    }
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 34, DeviceWidth - 30, 1)];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:lineView];
//}

// 设置包含日历的item的scrollView
- (void)setupScrollView {
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setFrame:CGRectMake(0, 5, DeviceWidth, self.centerCalendarItem.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(3 * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self addSubview:self.scrollView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.centerCalendarItem.frame.size.height+8, DeviceWidth, 0.5)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
}

// 设置3个日历的item
- (void)setupCalendarItems{
    self.scrollView = [[UIScrollView alloc] init];
    
    self.leftCalendarItem = [[FDCalendarItem2 alloc] init];
    [self.scrollView addSubview:self.leftCalendarItem];
    
    CGRect itemFrame = self.leftCalendarItem.frame;
    itemFrame.origin.x = DeviceWidth;
    self.centerCalendarItem = [[FDCalendarItem2 alloc] init];
    self.centerCalendarItem.frame = itemFrame;
    self.centerCalendarItem.delegate = self;
    [self.scrollView addSubview:self.centerCalendarItem];
    
    itemFrame.origin.x = DeviceWidth * 2;
    self.rightCalendarItem = [[FDCalendarItem2 alloc] init];
    self.rightCalendarItem.frame = itemFrame;
    [self.scrollView addSubview:self.rightCalendarItem];
    
    
}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date {
    self.centerCalendarItem.date = date;
    
    self.leftCalendarItem.date = [self.centerCalendarItem previousWeekdayDate];
    self.rightCalendarItem.date = [self.centerCalendarItem nextWeekdayDate];
    
//    [self.titleButton setTitle:[self stringFromDate:self.centerCalendarItem.date] forState:UIControlStateNormal];
}

// 重新加载日历items的数据
- (void)reloadCalendarItems {
    CGPoint offset = self.scrollView.contentOffset;
    
    if (offset.x == self.scrollView.frame.size.width) { //防止滑动一点点并不切换scrollview的视图
        return;
    }
    
    
    if (offset.x > self.scrollView.frame.size.width) {
        [self setNextWeekdayDate];
    } else {
        [self setPreviousWeekdayDate];
    }
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

#pragma mark - SEL
// 跳到上一个周
- (void)setPreviousWeekdayDate {
    self.date = [self.centerCalendarItem previousWeekdayDate];
    [self setCurrentDate:[self.centerCalendarItem previousWeekdayDate]];
}

// 跳到下一个周
- (void)setNextWeekdayDate {
    self.date = [self.centerCalendarItem nextWeekdayDate];
    [self setCurrentDate:[self.centerCalendarItem nextWeekdayDate]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadCalendarItems];
}

#pragma mark - FDCalendarItemDelegate

- (void)calendarItem:(FDCalendarItem2 *)item didSelectedDate:(NSDate *)date {
    self.date = date;
    [self setCurrentDate:self.date];
}

@end
