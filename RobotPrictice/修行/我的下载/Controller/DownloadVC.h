//
//  DownloadVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface DownloadVC : RootViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *musicBtn;
@property (strong, nonatomic) IBOutlet UIButton *txtBtn;
@property (strong, nonatomic) IBOutlet UILabel *musicLine;
@property (strong, nonatomic) IBOutlet UILabel *txtLine;

@property (nonatomic,assign) NSInteger titleClickMark;//1佛乐宝库 2是藏经阁
@end
