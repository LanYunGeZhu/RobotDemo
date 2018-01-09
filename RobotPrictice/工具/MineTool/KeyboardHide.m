//
//  KeyboardHide.m
//  RobotPrictice
//
//  Created by SongFeng on 17/3/7.
//  Copyright © 2017年 宋丰. All rights reserved.
//

#import "KeyboardHide.h"

@interface KeyboardHide ()

@end

@implementation KeyboardHide

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    
    // add Gesture
    [notificationCenter addObserverForName:UIKeyboardWillShowNotification
                                    object:nil
                                     queue:mainQuene
                                usingBlock:^(NSNotification *note){
                                    [self.view addGestureRecognizer:singleTapGR];
                                }];
    
    // remove Gesture
    [notificationCenter addObserverForName:UIKeyboardWillHideNotification
                                    object:nil
                                     queue:mainQuene
                                usingBlock:^(NSNotification *note){
                                    [self.view removeGestureRecognizer:singleTapGR];
                                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}


@end
