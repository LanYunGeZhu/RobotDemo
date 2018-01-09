//
//  CloudManageVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/16.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "CloudManageVC.h"

@interface CloudManageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseButton *but1;
    BaseButton *but2;
}
@end

@implementation CloudManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    [self addNav];
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
}
- (void)button2:(UIButton *)btn{
    NSLog(@"藏经阁");
    [self.tableView reloadData];
    
    [but2 setTitleColor:NavTabColor forState:(UIControlStateNormal)];
    [but2 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    
    [but1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [but1 setBackgroundImage: [self createImageWithColor:NavTabColor] forState:(UIControlStateNormal)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight*60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CloudManageCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CloudManageCell"];
    if (cell == nil) {
        cell = [CloudManageCell loadAboutCellWithType:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.downLoadBtn.tag = indexPath.row;
    [cell.downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

- (void)downLoad:(UIButton *)btn{
    NSLog(@"下载");
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
@end
