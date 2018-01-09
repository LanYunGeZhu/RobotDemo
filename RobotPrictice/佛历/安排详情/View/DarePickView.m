//
//  DarePickView.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/6.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "DarePickView.h"

@implementation DarePickView
+(DarePickView *)loadNibName{
    DarePickView *darepickView = [[[UINib nibWithNibName:@"DarePickView" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    darepickView.layer.cornerRadius = 5;
    darepickView.datePickView.backgroundColor = RGBA(246, 247, 247, 1);
    return darepickView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
