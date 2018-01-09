//
//  MultiselectVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/21.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface MultiselectVC : RootViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) NSInteger mark;//1代表我的早课 2代表我的晚课 3代表我的下载

@property (strong, nonatomic) IBOutlet UILabel *btn1Lab;
@property (strong, nonatomic) IBOutlet UILabel *btn2Lab;
@property (strong, nonatomic) IBOutlet UILabel *btn3Lab;
@property (strong, nonatomic) IBOutlet UILabel *btn4Lab;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@end
