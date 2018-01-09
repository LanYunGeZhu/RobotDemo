//
//  MatinCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/20.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatinCell : UITableViewCell

+(instancetype)loadAboutCellWithType:(int)type;

@property (strong, nonatomic) IBOutlet UILabel *title1Lab;
@property (strong, nonatomic) IBOutlet UILabel *time1Lab;
@property (strong, nonatomic) IBOutlet UIButton *more1Btn;

@property (strong, nonatomic) IBOutlet UIView *slideView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) IBOutlet UIButton *addMatin;
@property (strong, nonatomic) IBOutlet UIButton *removeMatin;
@property (strong, nonatomic) IBOutlet UIButton *deleteMatin;
@property (strong, nonatomic) IBOutlet UIButton *syncMatin;

@property (nonatomic,assign) CGFloat oriPosition;
@end
