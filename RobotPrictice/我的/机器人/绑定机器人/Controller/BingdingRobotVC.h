//
//  BingdingRobotVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface BingdingRobotVC : RootViewController
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic)  NSString *lblStatus;//扫描二维码后得到的东
@end
