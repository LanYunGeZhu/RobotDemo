//
//  FDCalendarItem2.m
//  Calendar_SF
//
//  Created by SongFeng on 17/3/28.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "FDCalendarItem2.h"

@interface FDCalendarCell2 : UICollectionViewCell

- (UILabel *)dayLabel;
- (UILabel *)chineseDayLabel;

- (UIImageView *)roundImg;

@end

@implementation FDCalendarCell2 {
    UILabel *_dayLabel;
    UILabel *_chineseDayLabel;
    UIImageView *_roundImg;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:15];
        _dayLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - 6);
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}

- (UILabel *)chineseDayLabel {
    if (!_chineseDayLabel) {
        _chineseDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 10)];
        _chineseDayLabel.textAlignment = NSTextAlignmentCenter;
        _chineseDayLabel.font = [UIFont boldSystemFontOfSize:9];
        
        CGPoint point = _dayLabel.center;
        point.y += 15;
        _chineseDayLabel.center = point;
        [self addSubview:_chineseDayLabel];
    }
    return _chineseDayLabel;
}

- (UIImageView *)roundImg {
    if (!_roundImg) {
        _roundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
        _roundImg.contentMode = UIViewContentModeScaleAspectFit;
        CGPoint point = _chineseDayLabel.center;
        point.y += 8;
        _roundImg.center = point;
        [self addSubview:_roundImg];
    }
    return _roundImg;
}

@end

#define CollectionViewHorizonMargin 5
#define CollectionViewVerticalMargin 5

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

typedef NS_ENUM(NSUInteger, FDCalendarWeekday) {

    FDCalendarWeekdayPrevious = 0,//上星期
    FDCalendarWeekdayCurrent = 1,//当前星期
    FDCalendarWeekdayNext = 2,//下星期
};

@implementation FDCalendarItem2

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCollectionView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, self.collectionView.frame.size.height + CollectionViewVerticalMargin * 2)];
    }
    return self;
}

#pragma mark - Custom Accessors

- (void)setDate:(NSDate *)date {
    _date = date;
    [self.collectionView reloadData];
}

#pragma mark - Public
// 获取date的下个星期日期
- (NSDate *)nextWeekdayDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 7;
    NSDate *nextWeekdayDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextWeekdayDate;
}
// 获取date的上个星期日期
- (NSDate *)previousWeekdayDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -7;
    NSDate *previousWeekdayDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousWeekdayDate;
}

//获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}
// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

#pragma mark - Private
// collectionView显示日期单元，设置其属性
- (void)setupCollectionView {
    CGFloat itemWidth = (DeviceWidth - CollectionViewHorizonMargin * 2) / 7;
    CGFloat itemHeight = itemWidth;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    
    CGRect collectionViewFrame = CGRectMake(CollectionViewHorizonMargin, CollectionViewVerticalMargin, DeviceWidth - CollectionViewHorizonMargin * 2, itemHeight);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
    [self addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[FDCalendarCell2 class] forCellWithReuseIdentifier:@"CalendarCell2"];
}

// 获取data是本周第几天
- (NSDateComponents*)weekdayOfToday{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *theComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth fromDate:self.date];
    
    return theComponents;
    
}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取某月day的日期
- (NSDate *)dateOfWeekday:(FDCalendarWeekday)calendarWeekday WithDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date;
    
    switch (calendarWeekday) {
            
        case FDCalendarWeekdayPrevious://上周
            date = [self previousWeekdayDate];
            break;
            
        case FDCalendarWeekdayCurrent://本周
            date = [NSDate date];
            break;
            
        case FDCalendarWeekdayNext://下周
            date = [self nextWeekdayDate];
            break;
        default:
            break;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:day];
    NSDate *dateOfDay = [calendar dateFromComponents:components];
    return dateOfDay;
}

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    NSString *day;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    if (components.day == 1) {
        day = ChineseMonths[components.month - 1];
    } else {
        day = ChineseDays[components.day - 1];
    }
    
    return day;
}

#pragma mark - UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CalendarCell2";
    FDCalendarCell2 *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor blackColor];
    cell.chineseDayLabel.textColor = [UIColor blackColor];
    
    NSDateComponents *theComponents = [self weekdayOfToday];//date是本周第几天
    NSInteger weekOfDay = theComponents.day - (theComponents.weekday - 1) + indexPath.row;//cell上显示的日期
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];//date月总天数
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];//上月总天数
    
    NSInteger day;
    if (weekOfDay <= 0) {//上个月
        day = weekOfDay + totalDaysOfLastMonth;
    }else if (weekOfDay > totalDaysOfMonth){//下个月
        day = weekOfDay - totalDaysOfMonth;
    }else{
        day = weekOfDay;
    }
    cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
    cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfWeekday:FDCalendarWeekdayPrevious WithDay:day]];
    //
    if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date]) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.layer.cornerRadius = cell.frame.size.height / 2;
        cell.dayLabel.textColor = NavTabColor;
        cell.chineseDayLabel.textColor = NavTabColor;
    }
    
#pragma 添加节假日
    if (weekOfDay == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]) {
        cell.chineseDayLabel.text = @"释迦摩尼日";
        cell.roundImg.image = ImgName(@"选中点");
    }

    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self.date];
    
    //
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];//当月总天数
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];//上月总天数
    
    //选中的日期
    NSInteger selectDay;
    NSInteger weekOfDay = components.day - (components.weekday - 1) + indexPath.row;//cell上显示的日期
    if (weekOfDay <= 0) {
        selectDay = weekOfDay + totalDaysOfLastMonth;
    }else if (weekOfDay > totalDaysOfMonth){
        selectDay = weekOfDay - totalDaysOfMonth;
    }else{
        selectDay = weekOfDay;
    }

    //判断是月份是否改变
    NSInteger subtract = selectDay - components.day;
    if (subtract > 7) {
        [components setMonth:components.month - 1];
    }else if (subtract < -7){
        [components setMonth:components.month + 1];
    }
    //
    [components setDay:selectDay];
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }
}

@end
