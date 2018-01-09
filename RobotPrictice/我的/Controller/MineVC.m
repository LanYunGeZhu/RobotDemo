//
//  MineVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "MineVC.h"
#import "RobotPrictice-Swift.h"

@interface MineVC ()

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return BaseHeight*15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return BaseHeight*70;
    }
    return BaseHeight*60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {

        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        cell.textLabel.text = @"这里显示姓名";
        cell.detailTextLabel.text = @"这里显示手机号";


        return cell;
    }else{

        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        NSArray *imgArr = @[@"机器人",@"设置",@"意见反馈"];
        cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
        cell.textLabel.text = imgArr[indexPath.row];

        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonMessageVC *vc = [PersonMessageVC new];
        vc.title = @"修改用户名";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){

        BingdingRobotVC *vc1 = [BingdingRobotVC new];
        vc1.title = @"绑定机器人";
        RobotManageVC *vc2 = [RobotManageVC new];
        vc2.title = @"机器人";
        SettingsVC *vc3 = [SettingsVC new];
        vc3.title = @"设置";
        FeedBackVC*vc4 = [FeedBackVC new];
        vc4.title = @"意见反馈";

        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:vc2 animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:vc3 animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:vc4 animated:YES];
                break;

            default:
                break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击文章进入阅读界面
- (IBAction)aaa:(id)sender {
    
    [MBProgressHUD showMessage:@"本地文件第一次解析慢,以后就会秒进了"];
    
    NSURL * fileURL =[[NSBundle mainBundle]URLForResource:@"求魔" withExtension:@"txt"];
    
    HJReadPageController *readVC = [[HJReadPageController alloc]init];
    
    [HJReadParser separateLocalURL:fileURL complete:^(BOOL isOk) {
        
        [MBProgressHUD hideHUD];
        if (self != nil) {
            readVC.readModel = [HJReadModel readModelWithFileName:@"求魔"];
            [self.navigationController pushViewController:readVC animated:YES];
        }
        
    }];
    
}



@end
