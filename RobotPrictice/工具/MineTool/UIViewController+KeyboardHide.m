//
//  UIViewController+KeyboardHide.m
//  Vibin
//
//  Created by jiang jack on 11/11/13.
//  Copyright (c) 2013 Originate China. All rights reserved.
//

#import "UIViewController+KeyboardHide.h"

@implementation UINavigationController (KeyboardHide)

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
