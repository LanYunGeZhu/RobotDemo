//
//  PersonMessageVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "PersonMessageVC.h"

@interface PersonMessageVC ()

@end

@implementation PersonMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //右侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithText:@"保存" target:self action:@selector(saveBtn)];
    self.navigationItem.rightBarButtonItem = backItem;
}

- (void)saveBtn{
    if (_nameTF.text.length == 0) {
        [JCProgressHUD showErrorWithStatus:@"请输入用户名"];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
