//
//  MultiselectCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/21.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "MultiselectCell.h"

@implementation MultiselectCell

+ (instancetype)loadNibCell:(NSInteger)type{
    return [[NSBundle mainBundle]loadNibNamed:@"MultiselectCell" owner:nil options:nil][type];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"选中"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"未选中-1"];
                    }
                }
            }
        }
    }
}

@end
