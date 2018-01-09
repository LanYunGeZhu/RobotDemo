//
//  RobotManageVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RobotManageVC.h"

@interface RobotManageVC ()

@end

@implementation RobotManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"机器人";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cancleBindingBtn:(id)sender {
    
    SFAlertView *xlAlertView = [[SFAlertView alloc] initWithTitle:nil message:@"确认解除机器人绑定吗" sureBtn:@"确认" cancleBtn:@"取消"];
    xlAlertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            BingdingRobotVC *vc = [[BingdingRobotVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [xlAlertView showXLAlertView];
    
}
- (IBAction)checkCloudBtn:(id)sender {
    CloudManageVC *vc = [[CloudManageVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
