//
//  SyncView.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "SyncView.h"

@implementation SyncView

+ (SyncView *)loadNibName{
    SyncView *vvv = [[[UINib nibWithNibName:@"SyncView" bundle:nil]instantiateWithOwner:self options:nil] lastObject];
    vvv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    vvv.rootView.layer.cornerRadius = 5;
    vvv.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);
    vvv.cancelBtn.tag = 1;
    vvv.tureBtn.tag = 2;
    
    //立体动画旋转
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [vvv.myImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
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

- (IBAction)tureButton:(UIButton *)sender {
    
    if (self.resultIndex) {
        self.resultIndex(sender.tag);
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
