//
//  RootTabBarController.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootTabBarController.h"
#import "RootNavigationController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

- (void)configUI{
    
    //设置底部选项卡的背景颜色
    self.tabBar.barTintColor = NavTabColor;
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dic in dataArr) {
        Class class = NSClassFromString([dic objectForKey:@"nameVC"]);
        UIViewController *vc = [[class alloc]init];
        [self addChildVC:vc title:[dic objectForKey:@"title"] image:[dic objectForKey:@"icon"] selectedImage:[dic objectForKey:@"icon_select"]];
    }
    
}

-(void)addChildVC:(UIViewController*)childVC title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage{
    
    // 设置子视图控制器的文字(可以设置tabBar和navigationBar的文字)
    childVC.title=title;
    
    // 设置子视图控制器的tabBarItem图片,禁用图片渲染
    childVC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置选中和未选中状态的文字样式
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : BottomFontColor,NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    
    //为自控制器包装导航栏控制器
    RootNavigationController *naVC = [[RootNavigationController alloc]initWithRootViewController:childVC];
    
    //添加子控制器
    [self addChildViewController:naVC];
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
