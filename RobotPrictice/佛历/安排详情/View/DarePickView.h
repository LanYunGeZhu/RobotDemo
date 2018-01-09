//
//  DarePickView.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/6.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DarePickView : UIView
+ (DarePickView *)loadNibName;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *tureBtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickView;
@property (strong, nonatomic) IBOutlet UIView *view1;
@end
