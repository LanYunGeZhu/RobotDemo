//
//  ArrangeEditView.h
//  RobotPrictice
//
//  Created by SongFeng on 17/4/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangeEditView : UIView
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *manageBtn;

+ (ArrangeEditView *)loadNibName;
@end
