//
//  PromptTool.h
//  RobotPrictice
//
//  Created by SongFeng on 17/3/17.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromptTool : NSObject

+ (void)addPromptTitle:(NSString *)title addMessage:(NSString *)message addCancleTitle:(NSString *)cancleTitle addDefaultTitle:(NSString *)defaultTitle cacleButton:(void (^)())cacleBtn  tureButton:(void (^)())tureBtn rootViewController:(UIViewController *)vc addUIAlertControllerStyle:(UIAlertControllerStyle)style;

@end
