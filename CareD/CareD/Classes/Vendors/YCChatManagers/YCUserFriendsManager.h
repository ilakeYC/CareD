//
//  YCUserFriendsManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCUserFriendsManagerDelegate;
@interface YCUserFriendsManager : NSObject

@property (nonatomic,assign) id<YCUserFriendsManagerDelegate> delegate;

+ (instancetype)sharedFriendsManager;


///加载所有好友
- (NSArray *)reloadAllFriends;

///判断用户是不是好友
- (BOOL)userIsFriend:(AVUser *)user;

///按照昵称查找联系人
- (void)searchFriendByNickName:(NSString *)nickName;

///按照用户名查找联系人
- (void)searchFriendByUserName:(NSString *)userName;
- (void)searchFriendByUserName:(NSString *)userName result:(void(^)(AVUser *user))handel;
- (AVUser *)searchFriendByUserNameAndReturn:(NSString *)userName;

///通过用户一级加密用户名搜索联系人
- (void)searchFriendByUserNameForScan:(NSString *)userNameForScan;

///向当前用户中添加好友
- (BOOL)addFriend:(AVUser *)user;
@end

@protocol YCUserFriendsManagerDelegate <NSObject>

@optional

///按照昵称查找联系人开始
- (void)userFriendsManagerFriendSearchByNickNameStarted;
///按照昵称查找联系人结束
- (void)userFriendsManagerFriendSearchByNickName:(NSString *)nickName complete:(NSArray *)friendList;

///按照用户名查找联系人开始
- (void)userFriendsManagerFriendSearchByUserNameStarted;
///按照用户名查找联系人结束
- (void)userFriendsManagerFriendSearchByUserName:(NSString *)userName complete:(NSArray *)friendList;


///通过用户一级加密用户名搜索好友开始
- (void)userFriendsManagerFriendSearchByUserNameForScanStarted;
///通过用户一级加密用户名搜索好友结束
- (void)userFriendsManagerFriendSearchByUserNameForScan:(NSString *)userName complete:(NSArray *)friendList;
@end