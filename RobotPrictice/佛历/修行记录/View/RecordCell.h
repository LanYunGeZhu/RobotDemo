//
//  RecordCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/31.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell

+ (instancetype)loadNibName:(NSInteger)type;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong, nonatomic) IBOutlet UIView *boardView;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UIView *boardView2;
@property (strong, nonatomic) IBOutlet UIView *view2;
@end
