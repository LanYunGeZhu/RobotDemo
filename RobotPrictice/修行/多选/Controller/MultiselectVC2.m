//
//  MultiselectVC2.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/22.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "MultiselectVC2.h"
#import "MultiselectCell.h"

@interface MultiselectVC2 ()<UITableViewDelegate,UITableViewDataSource>
{
    SyncView *syncView;
}
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSMutableArray *deleteArr;
@property (assign, nonatomic) NSInteger deleteNum;
@property (nonatomic,strong) NSMutableArray *selectedArray;

@end

@implementation MultiselectVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedArray = [[NSMutableArray alloc]init];
    self.deleteArr = [[NSMutableArray alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 13; ++i) {
        [_dataArr addObject:@(i)];
    }
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //右侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithText:@"全选" target:self action:@selector(allChoose:)];
    self.navigationItem.rightBarButtonItem = backItem;
}

#define mark 全选按钮
- (void)allChoose:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    //清空选中数组
    [self.deleteArr removeAllObjects];
    for (NSInteger index = 0; index < self.dataArr.count; index ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        if (!btn.selected) {
            //取消全选
            //取消选中该行
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            [btn setTitle:@"全选" forState:(UIControlStateNormal)];
        }else{
            
            //全选
            //加入选中数组
            [self.deleteArr addObject:[self.dataArr objectAtIndex:indexPath.row]];
            //选中该行
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        }
    }
    
    self.title = [NSString stringWithFormat:@"已选中%ld项",self.deleteArr.count];
    
}

#define  mark 删除
- (IBAction)deleteMatin:(id)sender {
    if (self.deleteArr.count > 0) {
        
        SFAlertView *alertview = [[SFAlertView alloc]initWithTitle:nil message:@"确认删除当前选中的文件吗" sureBtn:@"确认" cancleBtn:@"取消"];
        alertview.resultIndex = ^(NSInteger index){
            if (index == 2) {
                
                [self.dataArr removeObjectsInArray:self.deleteArr];
                [self.deleteArr removeAllObjects];
                [self.tableView reloadData];
                self.title = [NSString stringWithFormat:@"已选中%ld项",self.deleteArr.count];
            }
        };
        [alertview showXLAlertView];
    }else{
        [MBProgressHUD showError:@"至少选择一项"];
    }
    

}
#define  mark 同步
- (IBAction)sycnMatin:(id)sender {
    if (self.deleteArr.count > 0) {
        
        syncView = [SyncView loadNibName];
        syncView.resultIndex = ^(NSInteger index){
            if (index == 2) {//最小化
                NSLog(@"最小化");
            }else if (index == 1){//取消
                NSLog(@"取消");
            }
        };
        [syncView show];
        
    }else{
        [MBProgressHUD showError:@"至少选择一项"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight *60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultiselectCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MultiselectCell"];
    if (cell == nil) {
        cell = [MultiselectCell loadNibCell:2];
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteArr addObject:[self.dataArr objectAtIndex:indexPath.row]];
    self.deleteNum += 1;
    self.title = [NSString stringWithFormat:@"已选中%ld项",self.deleteNum];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteArr removeObject:[self.dataArr objectAtIndex:indexPath.row]];
    self.deleteNum -= 1;
    self.title = [NSString stringWithFormat:@"已选中%ld项",self.deleteNum];
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
