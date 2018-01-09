//
//  PricticeVCCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PricticeVCCell : UITableViewCell
+(instancetype)loadAboutCellWithType:(int)type;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UIView *slideView;

@property (nonatomic,assign) CGFloat oriPosition;
@end
