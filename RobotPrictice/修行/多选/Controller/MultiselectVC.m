//
//  MultiselectVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/21.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "MultiselectVC.h"
#import "MultiselectCell.h"

@interface MultiselectVC ()<UITableViewDelegate,UITableViewDataSource>
{
    SyncView *syncView;
}
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSMutableArray *deleteArr;
@property (assign, nonatomic) NSInteger deleteNum;
@property (nonatomic,strong) NSMutableArray *selectedArray;


@end

@implementation MultiselectVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_mark == 1) {
        _btn1Lab.text = @"添加到早课";
        _btn2Lab.text = @"从早课移除";
        _imgView2.image = [UIImage imageNamed:@"0928-移除"];
    }else if (_mark == 2){
        _btn1Lab.text = @"添加到晚课";
        _btn2Lab.text = @"从晚课移除";
        _imgView2.image = [UIImage imageNamed:@"0928-移除"];
    }else if (_mark == 3){
        _btn1Lab.text = @"添加到早课";
        _btn2Lab.text = @"添加到晚课";
        _imgView2.image = [UIImage imageNamed:@"添加-(1)"];
    }
    
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
#define mark 添加到早课
- (IBAction)addMatin:(id)sender {
    if (self.deleteArr.count > 0) {
        [JCProgressHUD showSuccessWithStatus:@"添加成功"];
    }else{
        [MBProgressHUD showError:@"至少选择一项"];
    }
}
#define  mark 从早课移除
- (IBAction)removeMatin:(id)sender {
    if (self.deleteArr.count > 0) {
        SFAlertView *alertview = [[SFAlertView alloc]initWithTitle:nil message:@"确认将当前选中项目从早课移除吗" sureBtn:@"确认" cancleBtn:@"取消"];
        alertview.resultIndex = ^(NSInteger index){
            if (index == 2) {
                
                [JCProgressHUD showSuccessWithStatus:@"移除成功"];
            }
        };
        [alertview showXLAlertView];
    }else{
        [MBProgressHUD showError:@"至少选择一项"];
    }
}
#define  mark 删除
- (IBAction)deleteMatin:(id)sender {
    if (self.deleteArr.count > 0) {
        
        NSString *str = [NSString stringWithFormat:@"确认删除当前选中%ld个文件吗",self.deleteArr.count];
        SFAlertView *alertview = [[SFAlertView alloc]initWithTitle:nil message:str sureBtn:@"确认" cancleBtn:@"取消"];
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
    
    if (indexPath.row < 3 && _mark != 3) {
        
        MultiselectCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MultiselectCell"];
        if (cell == nil) {
            cell = [MultiselectCell loadNibCell:0];
        }
        
        return cell;
        
    }else{
        
        MultiselectCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MultiselectCell"];
        if (cell == nil) {
            cell = [MultiselectCell loadNibCell:1];
        }
        
        return cell;
        
    }
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

//是否可以编辑  默认的时YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
    }
    
}
@end
