//
//  RepositoryCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/22.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RepositoryCell.h"

@implementation RepositoryCell

+(instancetype)loadAboutCellWithType:(int)type{
    return [[NSBundle mainBundle]loadNibNamed:@"RepositoryCell" owner:nil options:nil][type];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _oriPosition = self.slideView.frame.origin.x;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if ([self.reuseIdentifier isEqualToString:@"RepositoryCell0"] || [self.reuseIdentifier isEqualToString:@"RepositoryCell1"]) {
        
        if (selected == YES) {
            if (self.slideView.frame.origin.x >= 0) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.slideView.frame = CGRectMake(self.oriPosition, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
                }];
                
            }else{
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.slideView.frame = CGRectMake(0, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
                }];
                
            }
        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.slideView.frame = CGRectMake(self.oriPosition, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
            }];
        }
    }

}

- (IBAction)download:(id)sender {
    _downLoadImg.image = [UIImage imageNamed:@"已下载"];
}
- (IBAction)concern:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _concernImg.image = [UIImage imageNamed:@"收藏－已收藏"];
    }else{
        _concernImg.image = [UIImage imageNamed:@"关注2"];
    }
}

@end
