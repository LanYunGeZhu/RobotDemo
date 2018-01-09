//
//  UserInfo.h
//  HSH
//
//  Created by SongFeng on 16/4/29.
//  Copyright © 2016年 宋丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

// 单例
+ (UserInfo *)shareUserInfo;

// 判断是否登录
- (BOOL)isLogin;
- (BOOL)isLogout;

//是否记住密码
- (BOOL)isRemeberPSW;

/**
 *  用户信息
 */
- (NSDictionary *)userInfoDic;

/**
 *  保存密码
 */
- (BOOL)savePsw:(NSString *)psw;
/**
 *  获取密码
 */
- (NSString *)getPsw;

/**
 *  更新用户信息
 */
- (BOOL)updateUserInfo:(NSDictionary *)userData;



@end
