//
//  RepositoryCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/22.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoryCell : UITableViewCell

+(instancetype)loadAboutCellWithType:(int)type;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIImageView *downLoadImg;
@property (strong, nonatomic) IBOutlet UIButton *downLoadBtn;
@property (strong, nonatomic) IBOutlet UIImageView *concernImg;
@property (strong, nonatomic) IBOutlet UIButton *concernBtn;
@property (weak, nonatomic) IBOutlet UILabel *downloadNum;
@property (strong, nonatomic) IBOutlet UIView *slideView;
@property (strong, nonatomic) IBOutlet UIButton *slideButton;

@property (nonatomic,assign) CGFloat oriPosition;
@end
