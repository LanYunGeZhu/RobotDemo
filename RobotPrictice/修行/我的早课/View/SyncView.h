//
//  SyncView.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface SyncView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

+ (SyncView *)loadNibName;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (strong, nonatomic) IBOutlet UILabel *syncNum;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@property (strong, nonatomic) IBOutlet UIButton *tureBtn;

- (void)show;
- (void)dismiss;

@end
