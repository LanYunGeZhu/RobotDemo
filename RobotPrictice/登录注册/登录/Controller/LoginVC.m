//
//  LoginVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/14.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPasswordVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)loginBtn:(id)sender {
    
    //登录成功后将返回的信息存到本地
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"18888888888",@"username",@"123456",@"password",@"token",@"token" ,nil];
    [[UserInfo shareUserInfo] updateUserInfo:dic];
    
    RootTabBarController *tabVC = [[RootTabBarController alloc]init];
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    keyWindow.rootViewController = tabVC;
}
- (IBAction)registerBtn:(id)sender {
    RegisterVC *vc = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)forgetPassword:(id)sender {
    ForgetPasswordVC *vc = [[ForgetPasswordVC alloc]init];
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
