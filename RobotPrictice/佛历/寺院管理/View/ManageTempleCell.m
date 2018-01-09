//
//  ManageTempleCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ManageTempleCell.h"

@implementation ManageTempleCell
+ (instancetype)loadNibName:(NSInteger)type{
    return [[NSBundle mainBundle]loadNibNamed:@"ManageTempleCell" owner:nil options:nil][type];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
