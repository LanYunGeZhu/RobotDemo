//
//  LGViewController.m
//  LGSublimationView
//
//  Created by Luke Geiger on 05/12/2015.
//  Copyright (c) 2014 Luke Geiger. All rights reserved.
//

#import "LGViewController.h"
#import "AppDelegate.h"

@interface LGViewController () <LGSublimationViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign)NSUInteger page;

@end

@implementation LGViewController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super loadView];
    
    [self configUI];
    
}
-(void)configUI{
    LGSublimationView *lgSublimer = [[LGSublimationView alloc] initWithFrame:self.view.bounds];
    
    NSMutableArray *views = [NSMutableArray new];
    for (int i=1; i<=4; i++) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%i.jpg",i]];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.userInteractionEnabled = YES;
        [views addObject:view];
    }
    
    lgSublimer.delegate = self;    
    
    lgSublimer.viewsToSublime = views;
    
    UIView *shadeView = [[UIView alloc] initWithFrame:lgSublimer.frame];
    shadeView.backgroundColor = [UIColor blackColor];//阴影颜色
    shadeView.alpha = 0;
    shadeView.userInteractionEnabled = YES;
    lgSublimer.inbetweenView = shadeView;
    
    [self.view addSubview:lgSublimer];
}
#pragma mark - LGSublimationViewDelegate
-(void)lgSublimationView:(LGSublimationView *)view didEndScrollingOnPage:(NSUInteger)page{
    
    self.page = page;
    
    if ((int)page==4) {
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1; //手指数
        singleFingerOne.numberOfTapsRequired = 1; //tap次数
        singleFingerOne.delegate = self;
        [view addGestureRecognizer:singleFingerOne];
    }
    
}
//处理单指事件,即正式进入项目的主界面
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender{
    if (self.page == 4) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        LoginVC *loginVC = [[LoginVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.view.window.rootViewController = nav;
    }
}
@end
