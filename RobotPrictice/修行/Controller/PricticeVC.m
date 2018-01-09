//
//  PricticeVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "PricticeVC.h"
#import "ChooseIDView.h"

@interface PricticeVC ()
{
    NSIndexPath *selectInd;//当前播放下标,也就是选中的下标
    
    PlayMode currentMode;       //播放模式
    
    NSInteger markPlay;// 1为播放 0为暂停
    
    NSMutableArray *playListArray;    //播放歌曲地址列表
    AVPlayer *audioPlayer;     //播放器
    
    BOOL isPlaying;             //是否正在播放
}

@property (nonatomic, strong ) IBOutlet UIButton *btnPlay;        //播放/暂停按钮
@property (nonatomic, strong ) IBOutlet UIButton *preButton;      //上一首按钮
@property (nonatomic, strong ) IBOutlet UIButton *nextButton;     //下一首按钮
@property (nonatomic, strong) IBOutlet UIButton  *playModeButton;  //随机播放


@end

@implementation PricticeVC

- (void)viewWillAppear:(BOOL)animated{
    ChooseIDView *vvv = [ChooseIDView loadNibName];
    vvv.resultIndex = ^(NSInteger index){
        if (index == 1) {
            NSLog(@"选中居士");
        }else if (index == 2){
            NSLog(@"选中僧侣");
        }else{
            NSLog(@"未选择");
        }
    };
    [vvv show];
}

- (void)viewWillDisappear:(BOOL)animated{
    isPlaying = YES;
    [self doPlay];
}
#pragma 切换早课 晚课
- (IBAction)handoverClass:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _matinLab.text = @"晚课";
    }else{
        _matinLab.text = @"早课";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置各类控件启动时属性
    self.playModeButton.tag= 0;
    playListArray = [[NSMutableArray alloc]init];
    currentMode = 0;
    isPlaying = NO;
    playListArray = [[NSMutableArray alloc]init];
    
    //播放本地的
    for (int i = 0; i < 4; i++) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"本地歌曲%d",i+1] ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        [playListArray addObject:url];
    }
    
    //启动时播放第一首歌，也可记录上一次播放并保存，启动时播放上一首
    audioPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:playListArray[0]]];
    
    //增加通知，当播放完之后，要处理的工作：播放完后自动下一首
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayedidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    //增加观测者,播放状态切换时处理
    [audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //默认选中第一行播放列表
    selectInd = [NSIndexPath indexPathForRow:0 inSection:0];

    //默认选中行的音乐时间长
    _playTime.text = @"00:00";
    NSURL *url = playListArray[selectInd.row];
    _totalTime.text = [self formateDate:[NSString stringWithFormat:@"%ld",[self durationWithVideo:url]]];
    
#pragma 动态更新播放时间(只有播放时才会调用)
    [audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
        float currentTime = audioPlayer.currentItem.currentTime.value/ audioPlayer.currentItem.currentTime.timescale;
        if(currentTime){
            _playTime.text = [self formateDate:[NSString stringWithFormat:@"%f",currentTime]];
            
            NSURL *url = playListArray[selectInd.row];
            _totalTime.text = [self formateDate:[NSString stringWithFormat:@"%ld",[self durationWithVideo:url]]];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return playListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height/5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PricticeVCCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"PricticeVCCell"];
    if (!cell) {
        cell = [PricticeVCCell loadAboutCellWithType:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (playListArray.count > 0) {
        
        if (indexPath == selectInd && markPlay == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                cell.slideView.frame = CGRectMake(0, 0, cell.slideView.frame.size.width, cell.slideView.frame.size.height);
            }];
        }
        cell.titleLab.text = [NSString stringWithFormat:@"%ld.本地歌曲%ld",indexPath.row+1,indexPath.row+1];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n选中第%ld行",indexPath.row);
    
    PricticeVCCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    if (cell.slideView.frame.origin.x >= 0) {
        isPlaying = NO;
        [self doPlay];
        [_btnPlay setImage:[UIImage imageNamed:@"暂停-播放"] forState:(UIControlStateNormal)];
    }else{
        isPlaying = YES;
        [self doPlay];
        [_btnPlay setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
    }
    
    selectInd = indexPath;
}


#define mark 我的早课
- (IBAction)mineMatin:(id)sender {
    MatinVC *vc = [[MatinVC alloc]init];
    vc.title = @"我的早课";
    [self.navigationController pushViewController:vc animated:YES];
}
#define mark 我的晚课
- (IBAction)mineEvensong:(id)sender {
    EvensongVC *vc = [[EvensongVC alloc]init];
    vc.title = @"我的晚课";
    [self.navigationController pushViewController:vc animated:YES];
}
#define mark 我的下载
- (IBAction)mineDownload:(id)sender {
    DownloadVC *vc = [[DownloadVC alloc]init];
    vc.title = @"我的下载";
    [self.navigationController pushViewController:vc animated:YES];
}
#define mark 修行资源科
- (IBAction)repositoryBtn:(id)sender {
    RepositoryVC *vc = [[RepositoryVC alloc]init];
    vc.title = @"修行资源库";
    [self.navigationController pushViewController:vc animated:YES];
}
#define mark 修行提醒
- (IBAction)remindBtn:(id)sender {
    RemindVC *vc = [[RemindVC alloc]init];
    vc.title = @"修行提醒";
    [self.navigationController pushViewController:vc animated:YES];
}


#define mark 上一首
- (IBAction)doForwardBtn:(id)sender {
    
    PricticeVCCell *cell = [self.tableView cellForRowAtIndexPath:selectInd];
    
    if(currentMode ==SingleLoop){//单曲循环
        if(selectInd.row>0 && selectInd.row){
            NSInteger aaa = selectInd.row;
            aaa --;
            selectInd = [NSIndexPath indexPathForRow:aaa inSection:0];
        }else{
            selectInd = [NSIndexPath indexPathForRow:playListArray.count-1 inSection:0];
        }
    }
    
    [self playToForword];
    
    markPlay = 1;//

    PricticeVCCell *cell2 = [self.tableView cellForRowAtIndexPath:selectInd];
    
    _btnPlay.imageView.image = ImgName(@"暂停-播放");
    
    [UIView animateWithDuration:0.3 animations:^{
        cell.slideView.frame = CGRectMake(cell.oriPosition, 0, cell.slideView.frame.size.width, cell.slideView.frame.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        cell2.slideView.frame = CGRectMake(0, 0, cell2.slideView.frame.size.width, cell2.slideView.frame.size.height);
    }];
    
}
#define mark 下一首
- (IBAction)dumpToNextBtn:(id)sender {
    
    PricticeVCCell *cell = [self.tableView cellForRowAtIndexPath:selectInd];
    
    if(currentMode ==SingleLoop){//单曲循环
        //还有下一首，则播放
        if((selectInd.row +1)<playListArray.count){
            NSInteger aaa = selectInd.row;
            aaa ++;
            selectInd = [NSIndexPath indexPathForRow:aaa inSection:0];
        }
        //无下一首了，则循环到第一首
        else{
            selectInd = [NSIndexPath indexPathForRow:0 inSection:0];
        }
    }

    [self playToNext];
    
    markPlay = 1;//

    PricticeVCCell *cell2 = [self.tableView cellForRowAtIndexPath:selectInd];
    
    _btnPlay.imageView.image = ImgName(@"暂停-播放");
    
    [UIView animateWithDuration:0.3 animations:^{
        cell.slideView.frame = CGRectMake(cell.oriPosition, 0, cell.slideView.frame.size.width, cell.slideView.frame.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        cell2.slideView.frame = CGRectMake(0, 0, cell2.slideView.frame.size.width, cell2.slideView.frame.size.height);
    }];
    
}
#define mark 播放/暂停
- (IBAction)doPlayBtn:(UIButton*)sender {

    PricticeVCCell *cell = [self.tableView cellForRowAtIndexPath: selectInd];
    
    if (markPlay == 0) {
        markPlay = 1;
        isPlaying = NO;
        [self doPlay];
        
        [sender setImage:[UIImage imageNamed:@"暂停-播放"] forState:(UIControlStateNormal)];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.slideView.frame = CGRectMake(0, 0, cell.slideView.frame.size.width, cell.slideView.frame.size.height);
        }];
        
    }else if (markPlay == 1) {
        markPlay = 0;
        isPlaying = YES;
        [self doPlay];
        [sender setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.slideView.frame = CGRectMake(cell.oriPosition, 0, cell.slideView.frame.size.width, cell.slideView.frame.size.height);
        }];
    }

}
#define mark 循环播放
- (IBAction)changePlayModeBtn:(id)sender {
    [self changePlayMode:_playModeButton];
}

- (NSUInteger)durationWithVideo:(NSURL *)videoUrl{
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视频媒体文件
    NSUInteger second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    
    return second;
}

#pragma mark 格式化日期
- (NSString *)formateDate:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"mm:ss"];
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[strDate intValue]];
    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

-(void)changePlayMode:(UIButton *)btn{
    NSLog(@"变化前：tag为：%d",btn.tag);
    int newTag = (btn.tag+1)%3;
    
    _playModeButton.tag= newTag;
    
    NSLog(@"当前tag为：%d",newTag);
    
    PlayMode mode = (PlayMode)newTag+1;
    NSString *modestring ;
    switch (mode) {
        case SequenceList:
            modestring =@"循环-(1)";//循环播放
            break;
        case SingleLoop:
            modestring =@"单曲循环";//单曲循环
            break;
        case RandomList:
            modestring =@"随机播放";//随机播放
            break;
        default:
            break;
    }
    [btn setBackgroundImage:[UIImage imageNamed:modestring] forState:(UIControlStateNormal)];
    currentMode = mode;
    
    NSLog(@"当前播放模式：%@", modestring);
    
}

//播放完后，播放下一首
-(void)PlayedidEnd{
    NSLog(@"播放完毕");
    [self playToNext];
}

//状态切换时，要做的共走
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"status"]){
        if(audioPlayer.status ==AVPlayerStatusReadyToPlay){
            [self.btnPlay setEnabled: YES];
            //
        }
    }
}

//播放 或暂停
-(void)doPlay{
    if(isPlaying){                      //如果当前是播放的，点击后切换为暂停， 按钮显示“播放”
        [audioPlayer pause];
        isPlaying = NO;
        [self.btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    }
    else {                              //如果当前是暂停的，点击后切换为播放，按钮显示“暂停”
        [audioPlayer play];
        isPlaying = YES;
        [self.btnPlay setTitle:@"暂停" forState:UIControlStateNormal];
        
    }
}

//获取一个随机的歌曲下标
-(int)getRandomIndex{
    int i = arc4random() %playListArray.count;
    NSLog(@"\n\n总歌曲数%ld\n\n随机数=%d\n\n选中行=%ld",playListArray.count,i,selectInd.row);
    if (i < 0) {
        i = 0;
    }
    if(i!=(int)selectInd.row) return i;
    else return [self getRandomIndex];
}
//点击上一首按钮
-(void)doForward{
    if (currentMode ==RandomList) {
        int i=[self getRandomIndex];
        AVPlayerItem *preItem =[[AVPlayerItem alloc] initWithURL:playListArray[i]];
        [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
        [audioPlayer play];
        selectInd = [NSIndexPath indexPathForRow:i inSection:0];
    }
    else{
        if(selectInd.row>0){
            NSLog(@"\n\n播放第%ld首",selectInd.row);
            AVPlayerItem *preItem = [[AVPlayerItem alloc] initWithURL:playListArray[selectInd.row-1]];
            [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
            [audioPlayer play];
            NSInteger aaa = selectInd.row;
            aaa --;
            selectInd = [NSIndexPath indexPathForRow:aaa inSection:0];
        }else{
            NSLog(@"\n\n播放最后一首");
            AVPlayerItem *preItem = [[AVPlayerItem alloc] initWithURL:playListArray[playListArray.count-1]];
            [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
            [audioPlayer play];
            selectInd = [NSIndexPath indexPathForRow:playListArray.count-1 inSection:0];
        }

    }
}

//点击下一首按钮
-(void)dumpToNext{
    if(currentMode ==RandomList){
        int i = [self getRandomIndex];
        if (i < 0) {
            i = 0;
        }
        AVPlayerItem *preItem =[[AVPlayerItem alloc] initWithURL:playListArray[i]];
        [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
        [audioPlayer play];
        selectInd = [NSIndexPath indexPathForRow:i inSection:0];
    }
    else{
        //还有下一首，则播放
        if((selectInd.row +1)<playListArray.count){
            AVPlayerItem *nextItem = [[AVPlayerItem alloc] initWithURL:playListArray[selectInd.row+1]];
            [audioPlayer replaceCurrentItemWithPlayerItem:nextItem];
            [audioPlayer play];
            NSInteger aaa = selectInd.row;
            aaa ++;
            selectInd = [NSIndexPath indexPathForRow:aaa inSection:0];
        }
        //无下一首了，则循环到第一首
        else{
            AVPlayerItem *nextItem = [[AVPlayerItem alloc] initWithURL:playListArray[0]];
            [audioPlayer replaceCurrentItemWithPlayerItem:nextItem];
            [audioPlayer play];
            selectInd = [NSIndexPath indexPathForRow:0 inSection:0];
        }

    }
    
}

//自然播放到下一首
-(void)playToNext{

    if(currentMode ==SingleLoop){
        AVPlayerItem *preItem =[[AVPlayerItem alloc] initWithURL:playListArray[selectInd.row]];
        [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
        [audioPlayer play];
    }
    else{
        [self dumpToNext];
    }
}
//自然播放上一首
-(void)playToForword{
    
    if(currentMode ==SingleLoop){
        AVPlayerItem *preItem =[[AVPlayerItem alloc] initWithURL:playListArray[selectInd.row]];
        [audioPlayer replaceCurrentItemWithPlayerItem:preItem];
        [audioPlayer play];
    }
    else{
        [self doForward];
    }
}

//播放状态时间信息，demo暂时没用上
-(NSTimeInterval) availableDuration{
    NSArray *loadedTimeRanges = [[audioPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durations = CMTimeGetSeconds(timeRange.duration);
    
    NSTimeInterval result = startSeconds+durations;
    
    NSLog(@"\n时间：%f",result);
    
    return result;
}

@end
