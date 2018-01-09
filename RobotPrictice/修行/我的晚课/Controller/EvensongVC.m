//
//  EvensongVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "EvensongVC.h"
#import "EvensongBottomView.h"

@interface EvensongVC ()<UITableViewDelegate,UITableViewDataSource>
{
    SFPlayTool *playTool;

    NSIndexPath *selectInd;
    BOOL selectBool;
}

@property (nonatomic,assign) NSInteger sectionCount;
@property (nonatomic,assign) NSInteger chooseSection;//选中的区

@property (nonatomic,strong) NSMutableDictionary *selecStateDic;

@end

@implementation EvensongVC
- (void)aaa{
    [playTool removeObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aaa) name:@"removePlayAddObserver" object:nil];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _selecStateDic = [[NSMutableDictionary alloc]init];
    
    //设置各类控件启动时属性
    playTool = [SFPlayTool new];
    playTool.playListArray = [[NSMutableArray alloc]init];
    playTool.currentMode = 0;
    playTool.isPlaying = NO;
    
    //播放本地的
    for (int i = 0; i < 4; i++) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"本地歌曲%d",i+1] ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        [playTool.playListArray addObject:url];
    }
    
    [playTool setPlay];
    
    //默认选中第一行播放列表
    selectInd = [NSIndexPath indexPathForRow:0 inSection:0];
    
    _sectionCount = playTool.playListArray.count;
    
    for (int i = 0; i < _sectionCount; i++) {
        [_selecStateDic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
    //设置分割线
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
    //右侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"更多-(1)" highlightedImageName:@"更多-(1)" target:self action:@selector(allChoose)];
    self.navigationItem.rightBarButtonItem = backItem;
}
- (void)allChoose{
    [playTool doPlay:NO currentIndex:selectInd.row];
    [self.tableView reloadData];
    
    MultiselectVC *vc  = [[MultiselectVC alloc]init];
    vc.title = @"已选中0项";
    vc.mark = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    for (NSString *keyStr in _selecStateDic.allKeys) {
        NSString *iStr = [NSString stringWithFormat:@"%ld",section];
        if ([keyStr isEqualToString:iStr]) {
            
            NSString * status = _selecStateDic[keyStr];
            if ([status isEqualToString:@"1"]) {
                return BaseHeight*60;
            }else{
                return 0.01;
            }
        }
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    EvensongBottomView *view = [[EvensongBottomView alloc]init];
    view.view.frame = CGRectMake(0, 0, DeviceWidth, BaseHeight*60);
    view.addMatin.tag = section;
    [view.addMatin addTarget:self action:@selector(addMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
    view.removeMatin.tag = section;
    [view.removeMatin addTarget:self action:@selector(removeMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
    view.deleteMatin.tag = section;
    [view.deleteMatin addTarget:self action:@selector(deleteMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return view.view;
}

- (void)addMatinButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   添加到晚课",btn.tag);
}
- (void)removeMatinButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   从晚课移除",btn.tag);
}
- (void)deleteMatinButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   删除",btn.tag);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight *60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section%3 == 0) {
        
        MatinCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MatinCell"];
        if (cell == nil) {
            cell = [MatinCell loadAboutCellWithType:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.more1Btn.tag = indexPath.section;
        
        [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
        
    }else{
        
        MatinCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MatinCell"];
        if (cell == nil) {
            cell = [MatinCell loadAboutCellWithType:1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.more1Btn.tag = indexPath.section;
        
        [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
    
}

#define  mark -- 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MatinCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.slideView.frame.origin.x >= 0) {
        [playTool doPlay:YES currentIndex:selectInd.row];
    }else{
        [playTool doPlay:NO currentIndex:selectInd.row];
    }
}

- (void)moreButton:(UIButton *)btn{
    
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
