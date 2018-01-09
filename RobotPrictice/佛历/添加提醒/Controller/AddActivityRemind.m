//
//  AddActivityRemind.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "AddActivityRemind.h"
#import "DarePickView.h"

@interface AddActivityRemind ()<PassCurrentDateDelegate>{
    
    //时间设置
    UIDatePicker *datePick;
    UIToolbar *cancleBar;
    UIToolbar *tureBar;
    UIView *timeView;
    
    DarePickView *darepickView;
}

@end

@implementation AddActivityRemind

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
