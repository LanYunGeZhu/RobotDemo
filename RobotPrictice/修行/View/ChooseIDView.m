//
//  ChooseIDView.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ChooseIDView.h"

@implementation ChooseIDView

+ (ChooseIDView *)loadNibName{
    ChooseIDView *vvv = [[[UINib nibWithNibName:@"ChooseIDView" bundle:nil]instantiateWithOwner:self options:nil] lastObject];
    vvv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    vvv.rootView.layer.cornerRadius = 5;
    vvv.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);

    return vvv;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}

-(void)dismiss {
    [UIView animateWithDuration:.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
- (IBAction)button1:(id)sender {
    self.mark = 1;
}
- (IBAction)button2:(id)sender {
    self.mark = 2;
}
- (IBAction)tureButton:(UIButton *)sender {
    
    if (self.resultIndex) {
        self.resultIndex(_mark);
    }
    
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
