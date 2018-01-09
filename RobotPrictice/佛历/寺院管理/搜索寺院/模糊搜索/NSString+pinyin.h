//
//  NSString+pinyin.h
//  SearchDemo
//
//  Created by Azzan on 16/9/26.
//  Copyright © 2016年 Azzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)

/**
 *  拼音 -> pinyin
 */
- (NSString *)transformToPinyin;

/**
 *  拼音首字母 -> py
 */
- (NSString *)transformToPinyinFirstLetter;
@end
