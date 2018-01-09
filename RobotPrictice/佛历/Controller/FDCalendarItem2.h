//
//  FDCalendarItem2.h
//  Calendar_SF
//
//  Created by SongFeng on 17/3/28.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DeviceWidth [UIScreen mainScreen].bounds.size.width

@protocol FDCalendarItem2Delegate;

@interface FDCalendarItem2 : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSDate *date;
@property (weak, nonatomic) id<FDCalendarItem2Delegate> delegate;

- (NSDate *)nextWeekdayDate;
- (NSDate *)previousWeekdayDate;

@end

@protocol FDCalendarItem2Delegate <NSObject>

- (void)calendarItem:(FDCalendarItem2 *)item didSelectedDate:(NSDate *)date;

@end
