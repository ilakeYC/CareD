//
//  YCUserManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
    这个枚举 用来判断用户注册时返回的错误
    1 - 邮箱被占用
    2 - 用户名被占用
    3 - 网络状况不佳（其余错误均为）
 */
typedef NS_ENUM(NSUInteger, YCUserManagerRegisterError) {
    YCUserManagerRegisterErrorHasSameEmail = 1,
    YCUserManagerRegisterErrorHasSameUserName,
    YCUserManagerRegisterErrorNetworkingFailure,
    YCUserManagerRegisterErrorUserEmailIsNotvalid,
};


@protocol YCUserManagerDelegate;

@interface YCUserManager : NSObject
///单例代理方法
+ (instancetype)sharedUserManager;

///添加一个代理对象
- (void)addDelegate:(id<YCUserManagerDelegate>)delegate;

///联系融云服务器获得token
- (void)getRongCloudTokenWithUserId:(NSString *)userId UserNickName:(NSString *)userNickName tokenHandle:(void (^)(NSString *token))handel;

///用户注册通用方法
- (void)registerUser:(NSString *)userName
            password:(NSString *)password
               email:(NSString *)email;

///用户注册并且获得token
- (void)registerUserAndGetToken:(NSString *)userName
            password:(NSString *)password
               email:(NSString *)email;


///用户登录通用方法
- (void)logInWithUserName:(NSString *)userName password:(NSString *)password;
///用户登录并且返回token
- (void)logInReturnTokenWithUserName:(NSString *)userName password:(NSString *)password;

///设置用户昵称
- (void)setUserNickName:(NSString *)nickName;


///使用缓存用户登录
- (BOOL)logInWithCurrentUser;
///使用缓存用户登录
- (BOOL)logInWithCurrentUserAndReturnToken;


///通过旧密码更改密码
- (void)resetUserPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword;
- (void)resetUserPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword stateBlock:(void(^)(BOOL succeed))handle;
///通过邮箱找回密码
- (void)findPasswordByEmail:(NSString *)email;
///发送邮箱验证
- (void)sendEmailForVerify:(NSString *)email;

///注销登录
- (void)logOut;

///设置用户位置
- (void)setUserLocation:(userLocationModel *)locationModel;

///得到用户位置
- (userLocationModel *)getLocationByUser:(AVUser *)user;


///加密
- (NSString *)stringByEncryptionFromString:(NSString *)string;


@end

@protocol YCUserManagerDelegate <NSObject>

@optional
#pragma mark - 用户注册
////将要注册
- (void)userManagerRegisterWillRegister;
////注册成功
- (void)userManagerRegisterUserSuccessed:(AVUser *)user;
- (void)userManagerRegisterUserSuccessed:(AVUser *)user token:(NSString *)token;
////注册失败
- (void)userManagerRegisterUserFailure:(YCUserManagerRegisterError)error;
///验证邮件发送成功
- (void)usermanagerDidSendEmail;
///验证邮件发送失败
- (void)usermanagerSendEmailFailure;

#pragma mark - 用户登录
////将要使用当前用户登陆
- (void)userManagerLogInWillLoginWithCurrentUser;
////当前用户登录成功
- (void)userManagerLogInLoginWithCurrentUserSccessed:(AVUser *)currentUser;
////当前用户登录成功并且返回token
- (void)userManagerLogInLoginWithCurrentUserSccessed:(AVUser *)currentUser token:(NSString *)token;
////当前用户登录失败
- (void)userManagerLogInLoginWithCurrentUserFaliure;

////用户将要验证登录
- (void)userManagerLogInWillLoginWithUserNameAndPassword;
////用户登录成功
- (void)userManagerLogInLoginWithUserNameAndPasswordSuccessed:(AVUser *)user;
////用户登录成功并返回token
- (void)userManagerLogInLoginWithUserNameAndPasswordSuccessed:(AVUser *)user token:(NSString *)token;
////用户登录失败
- (void)userManagerLogInLoginWithUserNameAndPasswordFaliure;

///将要修改密码
- (void)userManagerWillResetUserPassword;
///修改密码成功
- (void)userManagerResetUserPasswordSuccessed;
///修改密码失败
- (void)userManagerResetUserPasswordFaliure;
@end