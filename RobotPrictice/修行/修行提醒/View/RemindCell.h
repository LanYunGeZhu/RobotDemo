//
//  RemindCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/20.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindCell : UITableViewCell

+(instancetype)loadAboutCellWithType:(int)type;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *onlyOneLab;
@property (strong, nonatomic) IBOutlet UIButton *switchBtn;

@property (nonatomic,assign) NSInteger mark;//1早课  2晚课

@end
