//
//  AddActivityRemind.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface AddActivityRemind : RootViewController

@property (strong, nonatomic) IBOutlet UITextField *titleTF;
@property (strong, nonatomic) IBOutlet UITextField *timeTF;
@property (strong, nonatomic) IBOutlet UIButton *chooseTimeBtn;
@property (strong, nonatomic) IBOutlet UITextField *contentTF;
@property (strong, nonatomic) IBOutlet UITextView *contentTV;

@end
