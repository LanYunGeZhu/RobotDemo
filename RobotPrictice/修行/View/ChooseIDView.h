//
//  ChooseIDView.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface ChooseIDView : UIView
@property (nonatomic,copy) AlertResult resultIndex;

+ (ChooseIDView *)loadNibName;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UIButton *tureBtn;

- (void)show;
- (void)dismiss;

@property (nonatomic,assign) NSInteger mark;

@end
