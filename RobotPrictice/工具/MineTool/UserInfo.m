//
//  UserInfo.m
//  HSH
//
//  Created by SongFeng on 16/4/29.
//  Copyright © 2016年 宋丰. All rights reserved.
//

#import "UserInfo.h"

#define ENCODE_KEY @"HAOYUANQU" // 编码key


/**
 *  用户信息本地的存储路径
 */
static NSString *const kUserInfoDicFileName = @"JQRUsername0320";
static NSString *const kUserPSWFileName = @"JQRPassword0320";
static UserInfo *userInfo = nil;

@interface UserInfo ()

- (NSString *)userFileFullPath;
- (NSString *)pswFileFullPath;

- (NSData *)simpleEncode:(NSString *)s;//编码
- (NSString *)simpleDecode:(NSData *)s;//反编码

@end

@implementation UserInfo

+ (UserInfo *)shareUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [UserInfo new];
    });
    return userInfo;
}

//是否登录－－－－－－－－－－－－－－－－－－
- (BOOL)isLogin {
    NSDictionary *info = [self userInfoDic];
    
    if ([info objectForKey:@"username"]) {
        return YES;
    }
    return NO;
}

/**
 *是否退出登录－－－－－－－－－－－－－－－－－
 */
- (BOOL)isLogout {
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithDictionary:[self userInfoDic]];
    [userDict removeAllObjects];
    
    // 刷新 本地信息
    [self updateUserInfo:userDict];
    
    return YES;
}
/**
 *是否记住密码－－－－－－－－－－－－－－－－－
 */
- (BOOL)isRemeberPSW {
    
    NSDictionary *userInfoDic = [self userInfoDic];
    if (userInfoDic && [[userInfoDic objectForKey:@"rememberPsw"] isEqualToString:@"true"]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Save and Get Password
//是否保存密码－－－－－－－－－－－
- (BOOL)savePsw:(NSString *)psw
{
    NSString *path = [self pswFileFullPath];
    
    //    Clear Saved Password
    if (!psw || [psw isEqualToString:@""]) {
        NSFileManager *fm = [NSFileManager defaultManager];
        return [fm removeItemAtPath:path error:nil];
    }
    NSData *pswArchivered = [self simpleEncode:psw];
    
    return [NSKeyedArchiver archiveRootObject:pswArchivered toFile:path];
}
//获取密码
- (NSString *)getPsw {
    NSString *path = [self pswFileFullPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        NSData *psw = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (psw && [psw length] > 0) {
            return [self simpleDecode:psw];
        }
    }
    
    return nil;
}



#pragma mark --- 用户本地存储路径 -----
/**
 *  用户信息本地的存储路径
 */
- (NSString *)userFileFullPath {
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullFilePath = [filePath stringByAppendingPathComponent:kUserInfoDicFileName];
    return fullFilePath;
}
/**
 *  用户密码的本地存储路径
 */
- (NSString *)pswFileFullPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [path stringByAppendingPathComponent:kUserPSWFileName];
    
    return fullPath;
}
/**
 *  用户信息－－－－－－－即请求的返回值
 */
- (NSDictionary *)userInfoDic {
    
    NSString *path = [self userFileFullPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        NSDictionary *info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if ([info.allKeys count] > 0) {
            return info;
        }
    }
    return nil;
}

// 更新 用户信息－－－－－－－－－更新后如果本地没数据就存储返回数据
- (BOOL)updateUserInfo:(NSDictionary *)userData {
    NSString *path = [self userFileFullPath];
    
    return [NSKeyedArchiver archiveRootObject:userData toFile:path];
}


#pragma mark --- DECODE and ENCODE ----
/**
 *  编码
 */
- (NSData *)simpleEncode:(NSString *)encode {
    
    NSData *data = [encode dataUsingEncoding:NSUTF8StringEncoding];
    
    char *dataPtr = (char *)[data bytes];
    char *keyData = (char *)[[ENCODE_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    for (int i = 0; i < [data length]; i++) {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        
        if (++keyIndex == [ENCODE_KEY length]) {
            keyIndex = 0;
            keyPtr = keyData;
        }
    }
    
    return data;
    
}

/**
 *  反编码
 */
- (NSString *)simpleDecode:(NSData *)decode {
    NSData *data = [NSData dataWithData:decode];
    
    char *dataPtr = (char *)[data bytes];
    char *keyData = (char *)[[ENCODE_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex =0;
    
    for (int i = 0; i < [data length]; i++) {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        
        if (++keyIndex == [ENCODE_KEY length]) {
            keyIndex = 0;
            keyPtr = keyData;
        }
    }
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}



@end
