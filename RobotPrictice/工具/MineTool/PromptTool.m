//
//  PromptTool.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/17.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "PromptTool.h"

@implementation PromptTool

+ (void)addPromptTitle:(NSString *)title addMessage:(NSString *)message addCancleTitle:(NSString *)cancleTitle addDefaultTitle:(NSString *)defaultTitle cacleButton:(void (^)())cacleBtn  tureButton:(void (^)())tureBtn rootViewController:(UIViewController *)vc addUIAlertControllerStyle:(UIAlertControllerStyle)style{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(style)];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:cancleTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cacleBtn();
    }];
    
    UIAlertAction *maketure = [UIAlertAction actionWithTitle:defaultTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        tureBtn();
    }];
    
    [alert addAction:cancle];
    
    [alert addAction:maketure];
    
    [vc.navigationController presentViewController:alert animated:YES completion:nil];

}

@end
