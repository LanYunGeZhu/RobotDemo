//
//  CalendarEditView.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/30.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarEditView : UIView
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *manageBtn;

+ (CalendarEditView *)loadNibName;
@end
