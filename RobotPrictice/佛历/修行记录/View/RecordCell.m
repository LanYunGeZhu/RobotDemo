//
//  RecordCell.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/31.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

+ (instancetype)loadNibName:(NSInteger)type
{
    return [[NSBundle mainBundle]loadNibNamed:@"RecordCell" owner:nil options:nil][type];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if ([self.reuseIdentifier isEqualToString:@"RecordCell0"] || [self.reuseIdentifier isEqualToString:@"RecordCell1"]) {
        _boardView.backgroundColor = [UIColor lightGrayColor];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_boardView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _boardView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        _boardView.layer.mask = maskLayer;
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:_view1.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
        
        CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
        
        maskLayer2.frame = _view1.bounds;
        
        maskLayer2.path = maskPath2.CGPath;
        
        _view1.layer.mask = maskLayer2;

    }
    else if ([self.reuseIdentifier isEqualToString:@"RecordCell3"]) {
        
        _boardView2.backgroundColor = [UIColor lightGrayColor];
        _boardView2.layer.masksToBounds = YES;
        _view2.layer.masksToBounds = YES;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_boardView2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15,15)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _boardView2.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        _boardView2.layer.mask = maskLayer;
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:_view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15,15)];
        
        CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
        
        maskLayer2.frame = _view2.bounds;
        
        maskLayer2.path = maskPath2.CGPath;
        
        _view2.layer.mask = maskLayer2;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
