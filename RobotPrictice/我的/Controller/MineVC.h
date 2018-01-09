//
//  MineVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
