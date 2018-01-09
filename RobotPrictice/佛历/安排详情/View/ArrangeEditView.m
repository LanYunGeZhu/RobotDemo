//
//  ArrangeEditView.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ArrangeEditView.h"

@implementation ArrangeEditView
+ (ArrangeEditView *)loadNibName{
    ArrangeEditView *editView = [[[UINib nibWithNibName:@"ArrangeEditView" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    return editView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
