//
//  SearchTempleCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "SearchTempleCell.h"

@implementation SearchTempleCell

+ (instancetype)loadNibName:(NSInteger)type{
    return [[NSBundle mainBundle]loadNibNamed:@"SearchTempleCell" owner:nil options:nil][type];
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
