//
//  ForgetPasswordVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/24.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "NewPasswordVC.h"

@interface ForgetPasswordVC ()

//将验证码直接赋到对应位置，用于测试
@property (nonatomic,strong)NSString *str;
//验证码倒计时参数
@property (nonatomic, assign) NSInteger reSendTime;
@property (nonatomic, strong) NSTimer *captchaTimer;

@end

@implementation ForgetPasswordVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _getCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
}
- (IBAction)nextButton:(id)sender {
    NewPasswordVC *vc = [[NewPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)getCodeBtn:(id)sender {
    
    //网络请求
    //    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:_phoneNumTF.text,@"username", nil];
    //    [AskTool loginPost:GET_IDENTIFY_USER_URL params:params success:^(id responseObj) {
    
    //设置验证码倒计时
    [_getCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"验证码剩余:60s" forState:UIControlStateNormal];
    _getCodeBtn.enabled = NO;
    _reSendTime = 60;
    _captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateReSendTime:) userInfo:nil repeats:YES];
    
    //        self.str = [responseObj objectForKey:@"msg"];
    //        self.messageTF.text = _str;
    //将验证码发送到手机
    
    //    } failure:^(NSError *error) {
    //
    //    }];
}

//验证码按钮倒计时
- (void)updateReSendTime:(NSTimer *)timer {
    
    if (_reSendTime > 0) {
        _reSendTime -= 1;
        [_getCodeBtn setTitle:[NSString stringWithFormat:@"验证码剩余:%lds", (long)_reSendTime] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        _captchaTimer = nil;
        
        [_getCodeBtn setBackgroundColor:NavTabColor];
        [_getCodeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _getCodeBtn.enabled = YES;
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
