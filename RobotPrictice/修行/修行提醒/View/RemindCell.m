//
//  RemindCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/20.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RemindCell.h"

@implementation RemindCell

+ (instancetype)loadAboutCellWithType:(int)type{
    return [[NSBundle mainBundle]loadNibNamed:@"RemindCell" owner:nil options:nil][type];
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
