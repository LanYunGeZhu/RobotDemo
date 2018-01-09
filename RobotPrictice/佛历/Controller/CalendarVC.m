//
//  CalendarVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "CalendarVC.h"
#import "FDCalendar.h"
#import "FDCalendar2.h"
#import "CalendarEditView.h"
#import "RecordCell.h"
#import "CalendarNav.h"
#import "AddActivityRemind.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]


@interface CalendarVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    FDCalendar *calendar;
    FDCalendar2 *calendar2;
    
    CalendarEditView *editView;
    
    CGFloat oldY;
    
    NSInteger flag;//1为月日历 2为周日历
}
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation CalendarVC

- (void)viewWillAppear:(BOOL)animated{
    [self addNav];//设置导航栏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = nil;
//    [self addNav];//设置导航栏
    [self addCalendar];//添加日历
    [self addWeekHeader];//添加星期天
    [self addTableView];
    
}
#pragma 返回今天按钮
- (void)todayButton{
    [calendar setCurrentDate:[NSDate date]];
    [calendar2 setCurrentDate:[NSDate date]];
    calendar.date = [NSDate date];
    calendar2.date = [NSDate date];
}
#pragma 编辑按钮
- (void)rightButton:(UIBarButtonItem *)btn{
    if (editView.hidden == YES) {
        [editView setHidden:NO];
    }else{
        [editView setHidden:YES];
    }
}
#pragma 添加提醒按钮
- (void)addRemindBtn{
    [editView setHidden:YES];
    AddActivityRemind *vc = [[AddActivityRemind alloc]init];
    vc.title = @"添加提醒";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma 管理寺院按钮
- (void)manageTempleBtn{
    [editView setHidden:YES];
    ManageTempleVC *vc = [[ManageTempleVC alloc]init];
    vc.title = @"寺院管理";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 滑动缩放日历
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.tableView]) {
        NSLog(@"\n%f\n%f",self.tableView.contentOffset.y,oldY);
        
        if (self.tableView.contentOffset.y > 5 && self.tableView.contentOffset.y < 100 && self.tableView.contentOffset.y > oldY) {//上滑
            
            [UIView animateWithDuration:0.5 animations:^{
                
                calendar2.date = calendar.date;
                [calendar2 setCurrentDate:calendar.date];
                [self.view addSubview:calendar2];
                [calendar removeFromSuperview];
                self.tableView.frame = CGRectMake(0, CGRectGetMaxY(calendar2.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(calendar2.frame) - 44);
                
            }];
            
        }else if (self.tableView.contentOffset.y < -30 && self.tableView.contentOffset.y < oldY) {//下滑
            
            [UIView animateWithDuration:0.5 animations:^{
                
                calendar.date = calendar2.date;
                [calendar setCurrentDate:calendar2.date];
                [self.view addSubview:calendar];
                [calendar2 removeFromSuperview];
                self.tableView.frame = CGRectMake(0, CGRectGetMaxY(calendar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(calendar.frame) - 44);
                
            }];
            
        }
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    oldY = self.tableView.contentOffset.y;
}

- (void)addNav{
    
    //自定义导航栏按钮
    CalendarNav *nav = [[CalendarNav alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [nav addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayButton)]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc] initWithCustomView:nav];
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy年MM月dd日"];
    NSString* s1 = [df stringFromDate:[NSDate date]];
    NSArray *dateAee = [s1 componentsSeparatedByString:@"年"];
    nav.yearLab.text = [NSString stringWithFormat:@"%@ · 今天",dateAee[0]];
    nav.monthLab.text = [NSString stringWithFormat:@"%@",dateAee[1]];

    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"更多-(1)" highlightedImageName:@"更多-(1)" target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = backItem;
    
    editView = [[CalendarEditView loadNibName]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];;
    editView.frame = CGRectMake(DeviceWidth - 115, 50, 100, 100);
    [editView.addBtn addTarget:self action:@selector(addRemindBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [editView.manageBtn addTarget:self action:@selector(manageTempleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [[UIApplication sharedApplication].keyWindow addSubview:editView];
    [editView setHidden:YES];
    
}
// 设置星期文字的显示
- (void)addWeekHeader {
    NSInteger count = [Weekdays count];
    CGFloat offsetX = 5;
    for (int i = 0; i < count; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 10, (DeviceWidth - 10) / count, 20)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.text = Weekdays[i];
        
        if (i == 0 || i == count - 1) {
            weekdayLabel.textColor = NavTabColor;
        } else {
            weekdayLabel.textColor = [UIColor blackColor];
        }
        
        [self.view addSubview:weekdayLabel];
        offsetX += weekdayLabel.frame.size.width;
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 34, DeviceWidth - 30, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
}
- (void)addCalendar{
    
    calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = calendar.frame;
    frame.origin.y = 30;
    calendar.frame = frame;
    [self.view addSubview:calendar];
    
    
    calendar2 = [[FDCalendar2 alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame2 = calendar2.frame;
    frame2.origin.y = 30;
    calendar2.frame = frame2;
    
}
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(calendar.frame) - 44) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentSize = CGSizeMake(0, DeviceHeight*3);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 20;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 10;
    }
    return BaseHeight*40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return nil;
    }
    UIView *headv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, BaseHeight*40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(BaseWidth*15, BaseHeight*10, 200, BaseHeight*20)];
    label.font = [UIFont systemFontOfSize:15];
    [headv addSubview:label];
    NSArray *arr = @[@"佛历",@"今日安排",@"修行记录"];
    label.text = arr[section];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    if (section != 0) {
        [headv addSubview:line];
    }
    return headv;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight*40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0 || indexPath.section == 1) {//佛理、提醒cell
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.imageView.image = ImgName(@"选中点");
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row+1];
        
        return cell;
    }else{
        RecordCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
        
        if (indexPath.row == 0) {
            if (!cell) {
                cell = [RecordCell loadNibName:0];
            }
            
            NSInteger mark;
            if (indexPath.section == 2) {
                cell.imgView.image = ImgName(@"早课");
                mark = 1;
            }else if (indexPath.section == 3){
                cell.imgView.image = ImgName(@"晚课");
                mark = 2;
            }
            cell.moreBtn.tag = mark;
            [cell.moreBtn addTarget:self action:@selector(allRecord:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }else if (indexPath.row == 2){
            cell = [RecordCell loadNibName:3];

        }else{
            
            cell = [RecordCell loadNibName:2];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        ArrangeDetailVC *vc = [[ArrangeDetailVC alloc]init];
        vc.title = @"详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)allRecord:(UIButton *)btn{
    RecordVC *vc = [[RecordVC alloc]init];
    vc.mark = btn.tag;
    vc.title = @"修行记录";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
