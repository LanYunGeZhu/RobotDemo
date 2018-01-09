//
//  RepositoryVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/15.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RepositoryVC.h"
#import "RepositoryCell.h"

#define  titleLabWidth  BaseWidth*100

@interface RepositoryVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    SFPlayTool *playTool;
    
    BaseButton *but1;
    BaseButton *but2;
    NSIndexPath *selectInd;
    BOOL selectBool;
}

@property (nonatomic,strong)NSArray *titleArray;//标题数组

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation RepositoryVC
- (void)aaa{
    [playTool removeObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aaa) name:@"removePlayAddObserver" object:nil];
    // Do any additional setup after loading the view from its nib.
    _dataArr = [[NSMutableArray alloc]init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollView.delegate = self;

    
    _titleClickMark = 1;//默认选中佛乐宝库
    self.titleArray = [NSArray arrayWithObjects:@"推荐下载",@"密咒真言",@"静心梵音",@"佛音传送",@"5",@"6", nil];
    [self addTitleLabel];
    
    //设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    [self addNav];
    
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
    
    [self.tableView reloadData];
}

#pragma mark--添加标题栏
- (void)addTitleLabel
{

    for (UIView *vvv in self.scrollView.subviews) {
        [vvv removeFromSuperview];
    }
    
    CGFloat hhh = BaseHeight *60;
    
    self.scrollView.contentSize = CGSizeMake(titleLabWidth*self.titleArray.count, 0);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    for (int i = 0; i< self.titleArray.count; i++) {
        
        ViewTool *rootlabel = [[ViewTool alloc]initWithFrame:CGRectMake(i*titleLabWidth, 0, titleLabWidth, hhh)];
        if (i == 0) {
            rootlabel.label.textColor = NavTabColor;
        }
        rootlabel.label.text = self.titleArray[i];
        rootlabel.tag = i;
        [self.scrollView addSubview:rootlabel];
        //给label添加轻拍手势触摸方法
        [rootlabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)]];
    }
}

#pragma mark--轻拍手势方法的实现
- (void)tapMethod:(UITapGestureRecognizer *)tap
{
    //设置轻拍的位置
    ViewTool *rootlabel = (ViewTool *)tap.view;
    for (ViewTool *vvv in self.scrollView.subviews) {
        if (vvv.tag == rootlabel.tag) {
            vvv.label.textColor = NavTabColor;
        }else{
            vvv.label.textColor = [UIColor blackColor];
        }
    }
    _positionMark = rootlabel.tag;
    NSLog(@"\n\n\n轻拍%@按钮",rootlabel.label.text);
    //设置轻拍一下contentScrollView的 X 偏移量
    CGFloat offsetX = titleLabWidth*(rootlabel.tag + 1);
    if (offsetX >= DeviceWidth) {
        int num = offsetX/DeviceWidth;
        int num2 = self.view.frame.size.width/100;
        offsetX = titleLabWidth*num2 *num;
        //将label的偏移量赋给contentScrollView
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    [self.tableView reloadData];
    
}

- (void)addNav{
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, BaseWidth*200, 30)];
    self.navigationItem.titleView = navView;
    navView.layer.borderWidth = 1.0;
    navView.layer.borderColor = [UIColor whiteColor].CGColor;
    navView.layer.cornerRadius = 5;
    navView.backgroundColor = [UIColor whiteColor];
    
    but1 = [[BaseButton alloc]init];
    but1.frame = CGRectMake(0, 0, BaseWidth*100, 30);
    [but1 setTitle:@"佛乐宝库" forState:(UIControlStateNormal)];
    [but1 addTarget:self action:@selector(button1:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:but1];
    
    but2 = [[BaseButton alloc]init];
    but2.frame = CGRectMake(BaseWidth*100, 0, BaseWidth*100, 30);
    [but2 setTitle:@"藏经阁" forState:(UIControlStateNormal)];
    [but2 addTarget:self action:@selector(button2:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:but2];
    
    [but1 setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [but1 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    
    [but2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [but2 setBackgroundImage: [self createImageWithColor:NavTabColor] forState:(UIControlStateNormal)];
    
}

- (void)button1:(UIButton *)btn{
    NSLog(@"佛乐宝库");
    [self.tableView reloadData];
    
    [but1 setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [but1 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    
    [but2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [but2 setBackgroundImage: [self createImageWithColor:NavTabColor] forState:(UIControlStateNormal)];
    
    _titleClickMark = 1;//默认选中佛乐宝库
    self.titleArray = [NSArray arrayWithObjects:@"推荐下载",@"密咒真言",@"静心梵音",@"佛音传送",@"5",@"6", nil];
    [self addTitleLabel];
    
    [self.tableView reloadData];
}
- (void)button2:(UIButton *)btn{
    NSLog(@"藏经阁");
    [self.tableView reloadData];
    
    [but2 setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [but2 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    
    [but1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [but1 setBackgroundImage: [self createImageWithColor:NavTabColor] forState:(UIControlStateNormal)];
    
    _titleClickMark = 2;//
    self.titleArray = [NSArray arrayWithObjects:@"研究",@"译文",@"咒语",@"善书",@"5",@"6", nil];
    [self addTitleLabel];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_titleClickMark == 1) {
        return playTool.playListArray.count;
    }
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight*60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_titleClickMark == 2) {//藏经阁
        
        RepositoryCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"RepositoryCell"];
        if (cell == nil) {
            cell = [RepositoryCell loadAboutCellWithType:2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.downLoadBtn.tag = indexPath.row;
        [cell.downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.concernBtn.tag = indexPath.row;
        [cell.concernBtn addTarget:self action:@selector(concern:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
    
    if (_titleClickMark == 1 && _positionMark == 0) {//佛乐宝库 推荐下载
        RepositoryCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"RepositoryCell"];
        if (cell == nil) {
            cell = [RepositoryCell loadAboutCellWithType:1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.downLoadBtn.tag = indexPath.row;
        [cell.downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.concernBtn.tag = indexPath.row;
        [cell.concernBtn addTarget:self action:@selector(concern:) forControlEvents:(UIControlEventTouchUpInside)];
 
        
        return cell;
    }
    
    //佛乐宝库
    RepositoryCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"RepositoryCell"];
    if (cell == nil) {
        cell = [RepositoryCell loadAboutCellWithType:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.downLoadBtn.tag = indexPath.row;
    [cell.downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.concernBtn.tag = indexPath.row;
    [cell.concernBtn addTarget:self action:@selector(concern:) forControlEvents:(UIControlEventTouchUpInside)];

    
    return cell;
}

#define  mark -- 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_titleClickMark == 1) {//点击佛乐宝库列表
        
        RepositoryCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.slideView.frame.origin.x >= 0) {
            [playTool doPlay:YES currentIndex:selectInd.row];
        }else{
            [playTool doPlay:NO currentIndex:selectInd.row];
        }
    }
}

- (void)downLoad:(UIButton *)btn{
    NSLog(@"下载");
}
- (void)concern:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        NSLog(@"关注");
    }else{
        NSLog(@"取消关注");
    }
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

- (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
