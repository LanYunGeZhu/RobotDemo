//
//  ManageTempleVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "ManageTempleVC.h"
#import "ManageTempleCell.h"

@interface ManageTempleVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ManageTempleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"关注" highlightedImageName:@"关注" target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem = backItem;
}

#pragma 关注寺院
- (void)rightButton{
    SearchTempleVC *vc = [[SearchTempleVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 关注开关
- (void)switchButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        
    }else{
        
    }
}
#pragma 删除按钮
- (void)delectButton:(UIButton *)btn{
    SFAlertView *aler = [[SFAlertView alloc]initWithTitle:nil message:@"确认删除" sureBtn:@"确认" cancleBtn:@"取消"];
    [aler showXLAlertView];
    aler.resultIndex = ^(NSInteger index){
        if (index == 2) {
            NSLog(@"点击确认");
        }
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight *50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageTempleCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"ManageTempleCell"];
    if (cell == nil) {
        cell = [ManageTempleCell loadNibName:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.switchBtn.tag = indexPath.row;
    cell.delectBtn.tag = indexPath.row;
    [cell.switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.delectBtn addTarget:self action:@selector(delectButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    return cell;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return BaseHeight *150;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, BaseHeight *200)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, BaseHeight*60, DeviceWidth, BaseHeight*20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击右上角，关注更多寺院";
    [view addSubview:label];
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2 - BaseWidth*37/2, BaseHeight*90, BaseWidth*37, BaseHeight *55)];
    imgview.image = ImgName(@"小图标");
    [view addSubview:imgview];
    
    return view;
}
@end
