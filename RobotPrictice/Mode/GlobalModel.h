//
//  GlobalModel.h
//  HSH
//
//  Created by SongFeng on 16/4/29.
//  Copyright © 2016年 宋丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *paystatus;

//消费者说 详情 评论列表 model
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *judge;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *picture;

//消费者说 详情 点赞和点评论 model
@property (nonatomic,strong) NSString *mainbody;
@property (nonatomic,strong) NSString *context;
@property (nonatomic,strong) NSString *pingnum;
@property (nonatomic,strong) NSString *num;

//优惠券详情
@property (nonatomic,strong) NSString *starttime;
@property (nonatomic,strong) NSString *endtime;

//消费调查详情
@property (nonatomic,strong) NSString *answer;
@property (nonatomic,strong) NSString *answerA;
@property (nonatomic,strong) NSString *answerB;
@property (nonatomic,strong) NSString *answerC;
@property (nonatomic,strong) NSString *answerD;
@property (nonatomic,strong) NSString *issue;
@property (nonatomic,strong) NSString *shequid;
@property (nonatomic,strong) NSString *pic2;
@property (nonatomic,strong) NSString *pic3;
@property (nonatomic,strong) NSString *num1;
@property (nonatomic,strong) NSString *num2;
@property (nonatomic,strong) NSString *num3;
@property (nonatomic,strong) NSString *num4;
@property (nonatomic,strong) NSString *sum;

@property (nonatomic,strong) NSString *introduce;
@end
