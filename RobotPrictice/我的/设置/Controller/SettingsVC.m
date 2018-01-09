//
//  SettingsVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _cacheLab.text = [self getSdHuanCun];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calendarBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"开启佛历提醒");

    }else{
        NSLog(@"关闭佛历提醒");

    }
}
- (IBAction)templeBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"开启寺院活动提醒");

    }else{
        NSLog(@"关闭寺院活动提醒");

    }
}
- (IBAction)clearCacheBtn:(id)sender {
    
    [PromptTool addPromptTitle:nil addMessage:nil addCancleTitle:@"取消" addDefaultTitle:@"清空下载内容" cacleButton:^{
        
        
    } tureButton:^{
        
        [[SDImageCache sharedImageCache] clearDisk];
        _cacheLab.text = nil;
        [JCProgressHUD showSuccessWithStatus:@"清理成功"];
        
    } rootViewController:self addUIAlertControllerStyle:(UIAlertControllerStyleActionSheet)];

}
- (IBAction)modifyPasswordBtn:(id)sender {
    ModifyPasswordVC *vc = [[ModifyPasswordVC alloc]init];
    vc.title = @"修改密码";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)aboutBtn:(id)sender {
    AboutUsVC *vc = [[AboutUsVC alloc]init];
    vc.title = @"关于";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginOutBtn:(id)sender {
    
    SFAlertView *xlAlertView = [[SFAlertView alloc] initWithTitle:nil message:@"确认退出登录吗" sureBtn:@"确认" cancleBtn:@"取消"];
    xlAlertView.resultIndex = ^(NSInteger index){
        
        if (index == 2) {
            
            [[UserInfo shareUserInfo]updateUserInfo:nil];
            
            LoginVC *logVC = [[LoginVC alloc]init];
            UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
            keyWindow.rootViewController = logVC;
        }
    };
    [xlAlertView showXLAlertView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSString *)getSdHuanCun{
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
    
    return currentVolum;
}
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

@end
