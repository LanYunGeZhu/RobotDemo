//
//  RecordVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/31.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordVC : RootViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger mark;//1为早课记录 2为晚课记录

@end
