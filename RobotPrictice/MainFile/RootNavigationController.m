//
//  RootNavigationController.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self coustomizeInterface];
}

//统一设置导航栏样式，包括导航栏上面的字体和颜色
- (void)coustomizeInterface{
    
    UINavigationBar *baseNavigationBar = [UINavigationBar appearance];
    baseNavigationBar.barTintColor = NavTabColor;
    baseNavigationBar.translucent = NO;//是否半透明
    
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    }else{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:17],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [baseNavigationBar setTitleTextAttributes:textAttributes];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {//调用push方法是隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
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
