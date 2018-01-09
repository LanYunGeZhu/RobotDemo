//
//  DownloadVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "DownloadVC.h"
#import "DownloadBottomView1.h"
#import "DownloadBottonView2.h"
#import "DownloadBottonView3.h"
#import "DownloadCell.h"


@interface DownloadVC ()<UITableViewDelegate,UITableViewDataSource>
{
    SFPlayTool *playTool;
    NSIndexPath *selectInd;
}

@property (nonatomic,assign) NSInteger chooseSection;//选中的区

@property (nonatomic,strong) NSMutableDictionary *selecStateDic;
@property (nonatomic,strong) NSMutableDictionary *playStateDic;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DownloadVC
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
    _playStateDic = [[NSMutableDictionary alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    _titleClickMark = 1;//默认选中佛乐宝库
    
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
    
    
    //假设有三行数据
    for (int i = 0; i <3; i++) {
        [_dataArr addObject:@"666"];
    }
    
    for (int i = 0; i < _dataArr.count; i++) {
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
    if (_titleClickMark == 1) {
        [playTool doPlay:NO currentIndex:selectInd.row];
        [self.tableView reloadData];
        
        MultiselectVC *vc  = [[MultiselectVC alloc]init];
        vc.title = @"已选中0项";
        vc.mark = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (_titleClickMark == 2){
        
        MultiselectVC2 *vc  = [[MultiselectVC2 alloc]init];
        vc.title = @"已选中0项";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_titleClickMark == 1) {
        return playTool.playListArray.count;
    }
    return _dataArr.count;
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
    
    if (_titleClickMark == 1) {
        
        if (section == 0) {
            DownloadBottomView1 *view = [[DownloadBottomView1 alloc]init];
            view.view.frame = CGRectMake(0, 0, DeviceWidth, BaseHeight*60);
            view.addMatinBtn.tag = section;
            [view.addMatinBtn addTarget:self action:@selector(addMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
            view.addEvensongBtn.tag = section;
            [view.addEvensongBtn addTarget:self action:@selector(addEvensongButton:) forControlEvents:(UIControlEventTouchUpInside)];
            view.delectBtn.tag = section;
            [view.delectBtn addTarget:self action:@selector(deleteMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return view.view;
        }else{
            DownloadBottonView2 *view = [[DownloadBottonView2 alloc]init];
            view.view.frame = CGRectMake(0, 0, DeviceWidth, BaseHeight*60);
            view.collectBtn.tag = section;
            [view.collectBtn addTarget:self action:@selector(collectButton:) forControlEvents:(UIControlEventTouchUpInside)];
            view.downloadBtn.tag = section;
            [view.downloadBtn addTarget:self action:@selector(downloadButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return view.view;
        }
        
    }else if (_titleClickMark == 2){
        
        if (section == 0) {
            DownloadBottonView3 *view = [[DownloadBottonView3 alloc]init];
            view.view.frame = CGRectMake(0, 0, DeviceWidth, BaseHeight*60);
            view.sycnBtn.tag = section;
            [view.sycnBtn addTarget:self action:@selector(sycnBtnButton:) forControlEvents:(UIControlEventTouchUpInside)];
            view.delectBtn.tag = section;
            [view.delectBtn addTarget:self action:@selector(deleteMatinButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return view.view;
        }else{
            DownloadBottonView2 *view = [[DownloadBottonView2 alloc]init];
            view.view.frame = CGRectMake(0, 0, DeviceWidth, BaseHeight*60);
            view.collectBtn.tag = section;
            [view.collectBtn addTarget:self action:@selector(collectButton:) forControlEvents:(UIControlEventTouchUpInside)];
            view.downloadBtn.tag = section;
            [view.downloadBtn addTarget:self action:@selector(downloadButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return view.view;
        }
        
    }
    
    return nil;
}

- (void)addMatinButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   添加到晚课",btn.tag);
}
- (void)addEvensongButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   添加到晚课",btn.tag);
}
- (void)sycnBtnButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   同步",btn.tag);
}
- (void)deleteMatinButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   删除",btn.tag);
}
- (void)collectButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   收藏",btn.tag);
}
- (void)downloadButton:(UIButton *)btn{
    NSLog(@"\n\n选中第%ld行   下载",btn.tag);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight *60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_titleClickMark == 1) {//佛乐宝库cell
        
        if (indexPath.section%3 == 0) {//已下载cell
            
            DownloadCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
            if (cell == nil) {
                cell = [DownloadCell loadAboutCellWithType:3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.more1Btn.tag = indexPath.section;
            
            [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];

            
            return cell;
            
        }else{//未下载cell
            
            DownloadCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
            if (cell == nil) {
                cell = [DownloadCell loadAboutCellWithType:2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.more1Btn.tag = indexPath.section;
            
            [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return cell;
        }
        
    }else if (_titleClickMark == 2){//藏经阁cell
        
        if (indexPath.section%3 == 0) {//已下载cell
            
            DownloadCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
            if (cell == nil) {
                cell = [DownloadCell loadAboutCellWithType:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.more1Btn.tag = indexPath.section;
            
            [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return cell;
            
        }else{//未下载cell
            
            DownloadCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
            if (cell == nil) {
                cell = [DownloadCell loadAboutCellWithType:1];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.more1Btn.tag = indexPath.section;
            
            [cell.more1Btn addTarget:self action:@selector(moreButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            return cell;
        }

        
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_titleClickMark == 1) {//点击佛乐宝库列表
        
        DownloadCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.slideView.frame.origin.x >= 0) {
            [playTool doPlay:YES currentIndex:selectInd.row];
        }else{
            [playTool doPlay:NO currentIndex:selectInd.row];
        }
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

- (IBAction)musicButton:(UIButton *)sender {
    _titleClickMark = 1;
    [_musicBtn setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [_txtBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _musicLine.backgroundColor = NavTabColor;
    _txtLine.backgroundColor = [UIColor clearColor];
    
    [self.tableView reloadData];
}
- (IBAction)txtButton:(UIButton *)sender {
    _titleClickMark = 2;
    [_txtBtn setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [_musicBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _txtLine.backgroundColor = NavTabColor ;
    _musicLine.backgroundColor = [UIColor clearColor];
    
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
