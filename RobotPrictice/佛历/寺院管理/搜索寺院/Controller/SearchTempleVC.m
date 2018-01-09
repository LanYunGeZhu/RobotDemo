//
//  SearchTempleVC.m
//  RobotPrictice
//
//  Created by SongFeng on 17/4/1.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "SearchTempleVC.h"
#import "SearchTempleCell.h"

@interface SearchTempleVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *searBar;
    UILabel * noResultLab;
}
// tableView
@property (weak, nonatomic) IBOutlet UITableView * tableView;
// 存储模型数组(所有数据)
@property (nonatomic, strong) NSMutableArray * storeUserDTOList;

// 搜索数组（搜索数据）
@property (nonatomic, strong) NSMutableArray * searchUserDTOList;

// 是否在搜索状态
@property (nonatomic, assign) BOOL isSearchState;
@end

@implementation SearchTempleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setUpForDismissKeyboard];
    // Do any additional setup after loading the view from its nib.
    self.storeUserDTOList = [[NSMutableArray alloc]init];
    self.searchUserDTOList = [[NSMutableArray alloc]init];
    [self addNav];
    [self setupUI];
    [self loadData];
}

#pragma 关注按钮
- (void)concernButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        
    }else{
        
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
- (void)addNav{
    searBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.navigationItem.titleView = searBar;
    searBar.delegate = self;
    
    UIBarButtonItem *rightbar = [UIBarButtonItem itemWithText:@"   " target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightbar;
    
}

- (void)setupUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    noResultLab = [[UILabel alloc] initWithFrame:CGRectMake(50,60,DeviceWidth/1.3, 40)];
    
    noResultLab.font = [UIFont systemFontOfSize:20];
    noResultLab.textColor = [UIColor lightGrayColor];
    noResultLab.hidden = YES;
    noResultLab.text = @"没有搜索到相关数据!";
    [self.view addSubview:noResultLab];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self startSearch:searchText];
}
// 开始所搜
- (void)startSearch:(NSString *)string{
    
    if (self.searchUserDTOList.count > 0) {
        
        [self.searchUserDTOList removeAllObjects];
    }
    
    // 开始搜索
    NSString * key = string.lowercaseString;
    NSMutableArray * tempArr = [NSMutableArray array];
    
    if (![key isEqualToString:@"" ] && ![key isEqual:[NSNull null]]) {
        
        [self.storeUserDTOList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UserDTO * dto = self.storeUserDTOList[idx];
            
            //担心框架有事后为误转, 再次都设置转为小写
            NSString * name = dto.name.lowercaseString;
            NSString * namePinyin = dto.namePinYin.lowercaseString;
            NSString * nameFirstLetter = dto.nameFirstLetter.lowercaseString;
            
            NSRange rang1 = [name rangeOfString:key];
            if (rang1.length > 0) {
                
                [tempArr addObject:dto];
            }else {
                if ([nameFirstLetter containsString:key]) {
                    
                    [tempArr addObject:dto];
                }else { //
                    if ([nameFirstLetter containsString:[key substringToIndex:1]]) {
                        
                        if ([namePinyin containsString:key]) {
                            [tempArr addObject:dto];
                        }
                    }
                }
            }
            
        }];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (![self.searchUserDTOList containsObject:tempArr[idx]]) {
                
                [self.searchUserDTOList addObject:tempArr[idx]];
            }
        }];
        
        self.isSearchState = YES;
        
    }else{
        
        self.isSearchState = NO;
    }
    
    [self.tableView reloadData];
    
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BaseHeight *50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_isSearchState) {
        
        if (self.searchUserDTOList.count > 0) {
            noResultLab.hidden = YES;
            return self.searchUserDTOList.count;
        }else {
            noResultLab.hidden = NO;
            return 0;
        }
    }else {
        noResultLab.hidden = YES;
        return self.storeUserDTOList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchTempleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTempleCell"];
    if (!cell) {
        cell = [SearchTempleCell loadNibName:0];
    }
    
    UserDTO * dto = nil;
    
    if (_isSearchState) {
        
        dto = self.searchUserDTOList[indexPath.row];
    }else {
        
        dto = self.storeUserDTOList[indexPath.row];
    }
    
    cell.titleLab.text = dto.name;
    cell.concernBtn.tag = indexPath.row;
    [cell.concernBtn addTarget:self action:@selector(concernButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

/**
 *  创建数据
 */
- (void)loadData{
    
    NSArray * nameArr = @[@"中国",@"联想",@"格力",@"苹果电脑",@"Iphone6s",@"中关村",@"东方明珠",@"美莲广场",@"火车站",@"MicroSoft",@"Oracle",@"凯迪拉克",@"甲骨文",@"MSUNSOFT",@"数据"];
    
    for (int i = 0; i < nameArr.count; i++) {
        
        UserDTO * dto = [[UserDTO alloc] init];
        
        // 转拼音
        NSString * PinYin = [nameArr[i] transformToPinyin];
        
        // 首字母
        NSString * FirstLetter = [nameArr[i] transformToPinyinFirstLetter];
        
        dto.name = nameArr[i];
        dto.namePinYin = PinYin;
        dto.nameFirstLetter = FirstLetter;
        
        [self.storeUserDTOList addObject:dto];
    }
    
    [self.tableView reloadData];
}


@end
