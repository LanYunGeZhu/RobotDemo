//
//  MultiselectCell.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/21.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiselectCell : UITableViewCell
+ (instancetype)loadNibCell:(NSInteger)type;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (nonatomic,assign) NSInteger allChooseMark;

@end
