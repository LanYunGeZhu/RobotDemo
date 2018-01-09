//
//  SearchTempleCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTempleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *concernBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
+ (instancetype)loadNibName:(NSInteger)type;
@end
