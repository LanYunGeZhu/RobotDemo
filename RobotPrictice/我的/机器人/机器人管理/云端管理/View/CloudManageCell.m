//
//  CloudManageCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/17.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "CloudManageCell.h"

@implementation CloudManageCell

+(instancetype)loadAboutCellWithType:(int)type{
    return [[NSBundle mainBundle]loadNibNamed:@"CloudManageCell" owner:nil options:nil][type];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)downLoadBtn:(id)sender {
    _imgView.image = [UIImage imageNamed:@"组-1.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
