//
//  MatinCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/20.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "MatinCell.h"

@implementation MatinCell

+ (instancetype)loadAboutCellWithType:(int)type{
    return [[NSBundle mainBundle]loadNibNamed:@"MatinCell" owner:nil options:nil][type];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _oriPosition = self.slideView.frame.origin.x;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected == YES) {
        if (self.slideView.frame.origin.x >= 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.slideView.frame = CGRectMake(self.oriPosition, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
            }];
            self.more1Btn.userInteractionEnabled = YES;
        }else{
            self.more1Btn.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.slideView.frame = CGRectMake(0, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
            }];
            
        }
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.slideView.frame = CGRectMake(self.oriPosition, 0, self.slideView.frame.size.width, self.slideView.frame.size.height);
        }];
        self.more1Btn.userInteractionEnabled = YES;

    }
    

}

@end
