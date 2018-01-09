//
//  ModifyPasswordVC.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface ModifyPasswordVC : RootViewController
@property (strong, nonatomic) IBOutlet UITextField *originPassword;
@property (strong, nonatomic) IBOutlet UITextField *newpassword;
@property (strong, nonatomic) IBOutlet UITextField *againWrite;

@end
