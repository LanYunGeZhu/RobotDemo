//
//  RootViewController.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //创建导航栏上的item
    [self createNavBarItem];

}

#pragma mark -创建导航栏上的item
-(void)createNavBarItem
{
    //隐藏系统的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //左侧自定义返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"返回" highlightedImageName:@"返回" target:self action:@selector(backItmClick)];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark -点击"返回"按钮
-(void)backItmClick{
    //移除观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePlayAddObserver" object:self];
    [self.navigationController popViewControllerAnimated:YES];
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
