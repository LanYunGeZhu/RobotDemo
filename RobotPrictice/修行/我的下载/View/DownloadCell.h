//
//  DownloadCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/22.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : UITableViewCell

+ (instancetype)loadAboutCellWithType:(NSInteger)type;

@property (strong, nonatomic) IBOutlet UILabel *title1Lab;
@property (strong, nonatomic) IBOutlet UILabel *time1Lab;
@property (strong, nonatomic) IBOutlet UIButton *more1Btn;

@property (strong, nonatomic) IBOutlet UIView *slideView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic,assign) CGFloat oriPosition;
@end
