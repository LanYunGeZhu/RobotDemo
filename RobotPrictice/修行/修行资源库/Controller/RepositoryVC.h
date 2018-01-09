//
//  RepositoryVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface RepositoryVC : RootViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lineScrollView;

@property (nonatomic,assign) NSInteger titleClickMark;//1佛乐宝库 2是藏经阁
@property (nonatomic,assign) NSInteger positionMark;//标记选中的title上第几个label
@end
