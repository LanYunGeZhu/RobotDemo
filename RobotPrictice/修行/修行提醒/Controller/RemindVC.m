//
//  RemindVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RemindVC.h"

@interface RemindVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableDictionary *selecStateDic;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation RemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _selecStateDic = [[NSMutableDictionary alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //右侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"添加2" highlightedImageName:@"添加2" target:self action:@selector(addBtn)];
    self.navigationItem.rightBarButtonItem = backItem;
    
    //假数据
    for (int i = 0; i < 6; i++) {
        [_dataArr addObject:@"09:00"];
    }
    for (int i = 0; i < _dataArr.count; i++) {
        [_selecStateDic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
    }
}
- (void)addBtn{
    ModifyRemindVC *vc  = [[ModifyRemindVC alloc]init];
    vc.title = @"添加提醒";
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BaseHeight*15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight*80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [RemindCell loadAboutCellWithType:0];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.switchBtn.tag = indexPath.row;
    [cell.switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSString *keyStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    if ([_selecStateDic[keyStr] isEqualToString:@"0"]) {//开启
        cell.imgView.image = [UIImage imageNamed:@"太阳辐射-开启"];
        [cell.switchBtn setBackgroundImage:ImgName(@"已开启") forState:(UIControlStateNormal)];
    }else{
        cell.imgView.image = [UIImage imageNamed:@"太阳辐射-未选中"];
        [cell.switchBtn setBackgroundImage:ImgName(@"未开启") forState:(UIControlStateNormal)];
        cell.timeLab.textColor = [UIColor grayColor];
        cell.onlyOneLab.textColor = [UIColor grayColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModifyRemindVC *vc  = [[ModifyRemindVC alloc]init];
    vc.title = @"修改提醒";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)switchButton:(UIButton *)btn{
    
    if (!btn.tag) {
        btn.tag = 0;
    }
    
    NSString *iStr = [NSString stringWithFormat:@"%ld",btn.tag];
    
    for (NSString *keyStr in _selecStateDic.allKeys) {
        if ([keyStr isEqualToString:iStr]) {
            if ([_selecStateDic[keyStr] isEqualToString:@"0"]) {
                [_selecStateDic setObject:@"1" forKey:keyStr];
            }else{
                [_selecStateDic setObject:@"0" forKey:keyStr];
            }
        }
    }
    
    [self.tableView reloadData];
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
