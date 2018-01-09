//
//  AppDelegate.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJAppDelegate
    
    /// 程序即将退出
-(void) applicationWillTerminate;
    
    /// 内存警告可能要终止程序
- (void) applicationDidReceiveMemoryWarning;
    
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (nonatomic,weak) id HJAppDelegate;

@property (strong, nonatomic) UIWindow *window;


@end

