//
//  ManageTempleCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTempleCell : UITableViewCell
+ (instancetype)loadNibName:(NSInteger)type;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIButton *switchBtn;
@property (strong, nonatomic) IBOutlet UIButton *delectBtn;
@end
