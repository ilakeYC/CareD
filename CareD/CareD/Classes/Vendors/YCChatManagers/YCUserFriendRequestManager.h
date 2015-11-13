//
//  YCUserFriendRequestManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, YCUserFriendRequest) {
    YCUserFriendRequestIsaRequest = 100,
    YCUserFriendRequestFeedBackYES,
    YCUserFriendRequestFeedBackNO,
};


@class AVUser;

@protocol YCUserFriendRequestManagerDelegate;

@interface YCUserFriendRequestManager : NSObject

@property (nonatomic,assign) id<YCUserFriendRequestManagerDelegate> delegate;


+ (instancetype)sharedUserFriendRequestManager;


////将密码合成用户好友请求并发送给某个用户
- (void)sendFriendRequestToUser:(AVUser *)user withPassword:(NSString *)password;

///返回同意添加
- (void)feedBackYESToUser:(AVUser *)user;
///返回拒绝添加
- (void)feedBackNOToUser:(AVUser *)user;

@end

@protocol YCUserFriendRequestManagerDelegate <NSObject>

///开始接收好友请求
- (void)userFriendRequestStartReceivingRequest;
///接收到好友请求
- (void)userFriendRequestReceivedRequestFrom:(AVUser *)user password:(NSString *)password;
///接收到好友回应，失败或成功
- (void)userFriendRequestReceivedRequestFeedBackWithUser:(AVUser *)user passed:(BOOL)passed;

///发送好友请求成功
- (void)userFriendRequestSendingRequestSuccessedToUser:(AVUser *)user andPassword:(NSString *)password;
///发送好友请求失败
- (void)userFriendRequestSendingRequestFailureToUser:(AVUser *)user andPassword:(NSString *)password;

///请求通过返回成功
- (void)userFriendRequestFeedBackYESTOUserSucceed:(AVUser *)user;
///请求通过返回失败
- (void)userFriendRequestFeedBackYESTOUserFailure:(AVUser *)user;
///请求拒绝返回成功
- (void)userFriendRequestFeedBackNOTOUserSucceed:(AVUser *)user;
///请求拒绝返回失败
- (void)userFriendRequestFeedBackNOTOUserFailure:(AVUser *)user;

@end