//
//  CloudManageCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/17.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudManageCell : UITableViewCell
+(instancetype)loadAboutCellWithType:(int)type;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIButton *downLoadBtn;
@end
