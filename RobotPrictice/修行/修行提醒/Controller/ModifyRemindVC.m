//
//  ModifyRemindVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/20.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ModifyRemindVC.h"

@interface ModifyRemindVC ()
@property (strong, nonatomic) IBOutlet UIImageView *chooseImg;
@property (strong, nonatomic) IBOutlet UIImageView *chooseImg2;
@property (strong, nonatomic) IBOutlet UIButton *everyday;
@property (strong, nonatomic) IBOutlet UIButton *onceButton;

@property (nonatomic,strong) NSString *messageStr;

@end

@implementation ModifyRemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.title isEqualToString:@"添加提醒"]) {
        _messageStr = @"确认保存当前新增闹钟吗";
    }else{
        _messageStr = @"确认修改当前闹钟吗";
    }
    
    [self.everyday setSelected:YES];
    
    //右侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithText:@"保存" target:self action:@selector(saveBtn)];
    self.navigationItem.rightBarButtonItem = backItem;
}

- (void)saveBtn{
    
    NSDate *date = [self.datePicker date];
    NSString *dataString = [self formateDate:date format:@"HH:mm"];
    NSLog(@"%@",dataString);
    
    SFAlertView *alert = [[SFAlertView alloc]initWithTitle:nil message:_messageStr sureBtn:@"确认" cancleBtn:@"取消"];
    alert.resultIndex = ^(NSInteger index){
        if (index == 2) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [alert showXLAlertView];
}
//每天
- (IBAction)everydayBtn:(UIButton *)sender {

    _chooseImg.image = [UIImage imageNamed:@"选中"];
    _chooseImg2.image = [UIImage imageNamed:@"未选中"];

}
//仅一次
- (IBAction)onceBtn:(UIButton *)sender {

    _chooseImg2.image = [UIImage imageNamed:@"选中"];
    _chooseImg.image = [UIImage imageNamed:@"未选中"];

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
#pragma mark 格式化日期
- (NSString *)formateDate:(NSDate *)date format:(NSString *)fomate
{
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc]init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:fomate];
    NSString *str = [NSString stringWithFormat:@"%@",[outPutFormatter stringFromDate:date]];
    return str;
}

@end
