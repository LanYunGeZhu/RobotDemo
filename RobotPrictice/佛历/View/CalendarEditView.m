//
//  CalendarEditView.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/30.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "CalendarEditView.h"

@interface CalendarEditView ()

@end

@implementation CalendarEditView

+ (CalendarEditView *)loadNibName{
    CalendarEditView *editView = [[[UINib nibWithNibName:@"CalendarEditView" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    return editView;
}


@end
