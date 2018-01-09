//
//  PricticeVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PlayMode){    //播放模式
    SequenceList=1,   //循环播放
    SingleLoop =2,     //单曲循环
    RandomList=3      //随机播放
};

@interface PricticeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *matinLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;


@property (strong, nonatomic) IBOutlet UILabel *playTime;
@property (strong, nonatomic) IBOutlet UILabel *totalTime;
@end
