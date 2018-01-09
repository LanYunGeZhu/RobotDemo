//
//  SFPlayTool.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/24.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFPlayTool : NSObject

@property (nonatomic,strong) AVPlayer *audioPlayer;     //播放器

@property (nonatomic,strong) AVPlayerItem *preItem;

@property (nonatomic,strong) NSMutableArray * playListArray;    //播放歌曲地址列表
//@property (nonatomic, strong )  UIButton *btnPlay;        //播放/暂停按钮
//@property (nonatomic, strong )  UIButton *preButton;      //上一首按钮
//@property (nonatomic, strong )  UIButton *nextButton;     //下一首按钮
@property (nonatomic, assign)  NSInteger playModeInt;  //随机播放

@property (nonatomic, assign)  NSInteger currentMode;  //播放模式  1循环播放 2单曲循环 3随机播放
@property (nonatomic, assign)  int currentIndex;          //当前播放下标
@property (nonatomic,assign) BOOL isPlaying;             //是否正在播放

@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;

- (void)setPlay;
//播放 或暂停
-(void)doPlay:(BOOL)isPlaying currentIndex:(NSInteger)index;
//点击下一首按钮
-(void)dumpToNext;
//点击上一首按钮
-(void)doForward;
//切换播放模式
-(void)changePlayMode:(NSInteger)playmodeint;
//移除观察者
- (void)removeObserver;
@end
