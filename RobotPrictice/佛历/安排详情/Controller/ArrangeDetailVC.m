//
//  ArrangeDetailVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/31.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ArrangeDetailVC.h"
#import "DarePickView.h"
#import "ArrangeEditView.h"

@interface ArrangeDetailVC ()<PassCurrentDateDelegate>{
    
    //时间设置
    UIDatePicker *datePick;
    UIToolbar *cancleBar;
    UIToolbar *tureBar;
    UIView *timeView;
    
    DarePickView *darepickView;
    
    ArrangeEditView *editView;
}

@end

@implementation ArrangeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"更多-(1)" highlightedImageName:@"更多-(1)" target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = backItem;
    
    editView = [[ArrangeEditView loadNibName]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];;
    editView.frame = CGRectMake(DeviceWidth - 115, 50, 100, 100);
    [editView.addBtn addTarget:self action:@selector(addRemindBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [editView.manageBtn addTarget:self action:@selector(manageTempleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [[UIApplication sharedApplication].keyWindow addSubview:editView];
    [editView setHidden:YES];
}

#pragma 导航栏右按钮
- (void)rightButton:(UIBarButtonItem *)btn{

    if (editView.hidden == YES) {
        [editView setHidden:NO];
    }else{
        [editView setHidden:YES];
    }
}
#pragma 编辑按钮
- (void)addRemindBtn{
    [editView setHidden:YES];

    self.timeTF.text = nil;
    self.titleTF.text = nil;
    self.contentTV.text = nil;
    self.contentTF.placeholder = @"请输入具体内容";
    
    self.titleTF.userInteractionEnabled = YES;
    self.contentTV.userInteractionEnabled = YES;
    self.chooseTimeBtn.userInteractionEnabled = YES;
    
}
#pragma 删除按钮
- (void)manageTempleBtn{
    [editView setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)choosetime:(id)sender {
    [self.view endEditing:YES];
    
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date] CompleteBlock:nil];
    datepicker.dateDelegate = self;
    datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
    
    [datepicker show];
    
    NSLog(@"\n\n默认选中日期：%@",datepicker.scrollToDate);
}
- (void)passCurrentDate:(NSDate *)currentdate{
    NSLog(@"\n\n打印选中日期：%@",currentdate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy/MM/dd eeee hh:mm"];
    _timeTF.text = [dateFormatter stringFromDate:currentdate];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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

- (void)chooseTime{
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat toolbarH = 38;
    timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    timeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeView];
    
    datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, height-216, width, 216)];
    [timeView addSubview:datePick];
    //设置中文
    datePick.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePick.backgroundColor = [UIColor whiteColor];
    //设置日期模式
    datePick.datePickerMode = UIDatePickerModeDate;
    //设置toolBar
    cancleBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, datePick.frame.origin.y - toolbarH, width, toolbarH)];
    cancleBar.tintColor = [UIColor blackColor];
    
    
}

@end
