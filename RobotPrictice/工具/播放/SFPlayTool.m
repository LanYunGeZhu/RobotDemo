//
//  SFPlayTool.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/24.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "SFPlayTool.h"

/**
 *  播放信息本地的存储路径
 */
static NSString *const kUserInfoDicFileName = @"JQRUsername0320";
static NSString *const kUserPSWFileName = @"JQRPassword0320";
static SFPlayTool *playTool = nil;


@implementation SFPlayTool

- (void)setPlay{

    //启动时播放第一首歌，也可记录上一次播放并保存，启动时播放上一首
    _audioPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:_playListArray[0]]];
    
    //增加通知，当播放完之后，要处理的工作：播放完后自动下一首
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayedidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    //增加观测者,播放状态切换时处理
    [_audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //
    _startTime = @"00:00";
    NSURL *urlll = _playListArray[0];
    _endTime = [self formateDate:[NSString stringWithFormat:@"%ld",[self durationWithVideo:urlll]]];

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

-(void)changePlayMode:(NSInteger)playmodeint{

    _currentMode = playmodeint;
        
}

//播放完后，播放下一首
-(void)PlayedidEnd{
    NSLog(@"播放完毕");
    [self playToNext];
}

//状态切换时，要做的共走
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"status"]){
        if(_audioPlayer.status ==AVPlayerStatusReadyToPlay){
//            [self.btnPlay setEnabled: YES];
            //
        }
    }
}

//播放 或暂停
-(void)doPlay:(BOOL)isPlaying currentIndex:(NSInteger)index{
    if(isPlaying == YES){
//        _preItem =[[AVPlayerItem alloc] initWithURL:_playListArray[index]];
//        [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
        [_audioPlayer play];
    }else {
        [_audioPlayer pause];
    }
}

//获取一个随机的歌曲下标
-(int)getRandomIndex{
    int i = arc4random() %_playListArray.count-1;
    
    if(i!=(int)_currentIndex) return i;
    else return [self getRandomIndex];
}

//点击上一首按钮
-(void)doForward{
    if (_currentMode ==3) {
        int i=[self getRandomIndex];
        _preItem =[[AVPlayerItem alloc] initWithURL:_playListArray[i]];
        [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
        [_audioPlayer play];
        _currentIndex=i;
    }
    else{
        if(_currentIndex-1>=0){
            NSLog(@"\n\n播放第%d首",_currentIndex);
            _preItem = [[AVPlayerItem alloc] initWithURL:_playListArray[_currentIndex-1]];
            [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
            [_audioPlayer play];
            _currentIndex --;
        }else{
            NSLog(@"\n\n已经到最后一首");
            _currentIndex = (int)_playListArray.count;
            _preItem = [[AVPlayerItem alloc] initWithURL:_playListArray[_currentIndex-1]];
            [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
            [_audioPlayer play];
            _currentIndex --;
        }
        
    }
}

//点击下一首按钮
-(void)dumpToNext{
    if(_currentMode ==3){
        int i = [self getRandomIndex];
        _preItem =[[AVPlayerItem alloc] initWithURL:_playListArray[i]];
        [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
        [_audioPlayer play];
        _currentIndex=i;
    }
    else{
        //还有下一首，则播放
        if((_currentIndex +1)<_playListArray.count){
            AVPlayerItem *nextItem = [[AVPlayerItem alloc] initWithURL:_playListArray[_currentIndex+1]];
            [_audioPlayer replaceCurrentItemWithPlayerItem:nextItem];
            [_audioPlayer play];
            _currentIndex++;
        }
        //无下一首了，则循环到第一首
        else{
            AVPlayerItem *nextItem = [[AVPlayerItem alloc] initWithURL:_playListArray[0]];
            [_audioPlayer replaceCurrentItemWithPlayerItem:nextItem];
            [_audioPlayer play];
            _currentIndex =0;
        }

    }
}

//自然播放到下一首
-(void)playToNext{
    if(_currentMode ==2){
        _preItem =[[AVPlayerItem alloc] initWithURL:_playListArray[_currentIndex]];
        [_audioPlayer replaceCurrentItemWithPlayerItem:_preItem];
        [_audioPlayer play];
    }
    else{
        [self dumpToNext];
    }
}

//播放状态时间信息，demo暂时没用上
-(NSTimeInterval) availableDuration{
    NSArray *loadedTimeRanges = [[_audioPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durations = CMTimeGetSeconds(timeRange.duration);
    
    NSTimeInterval result = startSeconds+durations;
    
    NSLog(@"\n时间：%f",result);
    
    return result;
}


- (void)removeObserver{
    
    if (self.audioPlayer && self.audioPlayer.currentItem) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self.audioPlayer removeObserver:self forKeyPath:@"status"];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self.audioPlayer];
        
    }
}
@end
