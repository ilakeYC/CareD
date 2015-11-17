//
//  YCUserFriendRequestManager.m
//  聊天测试
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCUserFriendRequestManager.h"
#import "YCUserDefines.h"
#import <AVOSCloudIM.h>
#import "YCUserFriendsManager.h"


#define YCUserFriendRequest_WantToAddFriend @"djfiasn8345278n34yvn28734ynoowerno3digawekdnashia"
#define YCUserFriendRequest_FeedBackRequestYES @"asdi2iq287y4onrwocfqi34oru8omciefj3nsnflaih3fa348"
#define YCUserFriendRequest_FeedBackRequestNO @"28roq84ryoq8ymroq834rq83mytx734ytw837rfmow3478tneort"

#define YCUserFriendRequest_LineBreakingFlag @"82lfsdnfui98fasldm98msdf298fhoifcno3efhxmouhf384yneuhmof"
#define YCUserFriendRequest_NOPasswordPlaceHolder @"2i3on8hsoeorqnm984fxeuhfnwo38mochroviwg3ufojq384nyfnoxmo"
#define YCUserFriendRequest_PasswordNO @"8ncroyq3ryoq384ryoqw89ryc3n4o87yomwc4fx3o487ycwoer8mfxo3"
#define YCUserFriendRequest_PasswordYES @"2i3noawefweoryq8wenmfxahueorf8wnkrmfhfpxwhe8f834yrox9m83"

#define YCUserFriendRequest__SenderID_KEY @"senderID"
#define YCUserFriendRequest__ReceiverID_KEY @"receiverID"
#define YCUserFriendRequest__RequestMessage_KEY @"requestMessage"
#define YCUserFriendRequest__Password_KEY @"password"
#define YCUserFriendRequest__IfHasPassword_KEY @"ifHasPassword"


@interface YCUserFriendRequestManager ()<AVIMClientDelegate>

@property (nonatomic,strong) AVIMClient *client;
@property (nonatomic,strong) AVIMClient *clientReceived;

///开始接受好友请求
- (void)startReceiveingFriendRequest;
@end

@implementation YCUserFriendRequestManager

+ (instancetype)sharedUserFriendRequestManager {
    
    static YCUserFriendRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
        [manager startReceiveingFriendRequest];
    });
    
    return manager;
}

- (void)startReceiveingFriendRequest {
    AVUser *user = [AVUser currentUser];
    NSString *userNameForChat = user[CARED_LEANCLOUD_USER_userNameForChat];
    
    self.clientReceived = [[AVIMClient alloc] init];
    self.clientReceived.delegate = self;
    [self.clientReceived openWithClientId:userNameForChat callback:^(BOOL succeeded, NSError *error) {
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestStartReceivingRequest)]) {
            [self.delegate userFriendRequestStartReceivingRequest];
        }
    }];
}

//接收到好友请求
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    
    [self rebuildReceivedRequestString:message.text];
    
}

//=====================将请求消息解体并解析
- (void)rebuildReceivedRequestString:(NSString *)string {
    if (!string) {
        return;
    }
    NSArray *stringArray = [string componentsSeparatedByString:YCUserFriendRequest_LineBreakingFlag];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:stringArray[0] forKey:YCUserFriendRequest__SenderID_KEY];
    [dictionary setObject:stringArray[1] forKey:YCUserFriendRequest__ReceiverID_KEY];
    [dictionary setObject:stringArray[2] forKey:YCUserFriendRequest__RequestMessage_KEY];
    [dictionary setObject:stringArray[3] forKey:YCUserFriendRequest__IfHasPassword_KEY];
    [dictionary setObject:stringArray[4] forKey:YCUserFriendRequest__Password_KEY];
    
    YCUserFriendRequest requestKind = [self chackForKindOfRequest:dictionary];
    if (requestKind == YCUserFriendRequestIsaRequest) {
        [self dealWithRequestIsaRequest:dictionary];
    }
    
    if (requestKind == YCUserFriendRequestFeedBackYES) {
        [self dealWithRequestFeedBackYes:dictionary];
    }
    
    if (requestKind == YCUserFriendRequestFeedBackNO) {
        [self dealWithRequestFeedBackNo:dictionary];
    }
    
    
}

//判断请求种类,判断消息目标是否正确
- (YCUserFriendRequest)chackForKindOfRequest:(NSDictionary *)dictionary {
    NSString *requestMessage = dictionary[YCUserFriendRequest__RequestMessage_KEY];
    NSString *messageUserNameForChat = dictionary[YCUserFriendRequest__ReceiverID_KEY];
    AVUser *currentUser = [AVUser currentUser];
    NSString *currentUserNameForChat = currentUser[CARED_LEANCLOUD_USER_userNameForChat];
    
    if (![currentUserNameForChat isEqualToString:messageUserNameForChat]) {
        return 0;
    }
    if ([requestMessage isEqualToString:YCUserFriendRequest_WantToAddFriend]) {
        return YCUserFriendRequestIsaRequest;
        //请求
    }
    if ([requestMessage isEqualToString:YCUserFriendRequest_FeedBackRequestYES]) {
        return YCUserFriendRequestFeedBackYES;
        //返回通过
    }
    if ([requestMessage isEqualToString:YCUserFriendRequest_FeedBackRequestNO]) {
        return YCUserFriendRequestFeedBackNO;
        //返回拒绝
    }
    
    return 0;
}

//处理请求
- (void)dealWithRequestIsaRequest:(NSDictionary *)dictionary {
    NSString *password = dictionary[YCUserFriendRequest__Password_KEY];
    NSString *fromUserNameForChat = dictionary[YCUserFriendRequest__SenderID_KEY];
    
    AVQuery *query = [AVUser query];
    [query whereKey:CARED_LEANCLOUD_USER_userNameForChat equalTo:fromUserNameForChat];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!objects) {
            return ;
        }
        
        AVUser *senderUser = [objects firstObject];
        
        
        [self.requestListDic setObject:password forKey:senderUser.username];
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"收到请求" object:nil]];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestReceivedRequestFrom:password:)]) {
            
            [self.delegate userFriendRequestReceivedRequestFrom:senderUser password:password];
            
        }
        
    }];
}

//处理成功回应
- (void)dealWithRequestFeedBackYes:(NSDictionary *)dictionary {
    NSString *fromUserNameForChat = dictionary[YCUserFriendRequest__SenderID_KEY];
    
    AVQuery *query = [AVUser query];
    [query whereKey:CARED_LEANCLOUD_USER_userNameForChat equalTo:fromUserNameForChat];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!objects) {
            return ;
        }
        
        AVUser *senderUser = [objects firstObject];
        
        if ([[YCUserFriendsManager sharedFriendsManager] addFriend:senderUser]) {
            [self.requestListDic removeObjectForKey:senderUser.username];
            
//            if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestReceivedRequestFeedBackWithUser:passed:)]) {
//                [self.delegate userFriendRequestReceivedRequestFeedBackWithUser:senderUser  passed:YES];
//            }
            
        }
    }];
    
    
}
//处理失败回应
- (void)dealWithRequestFeedBackNo:(NSDictionary *)dictionary {
    NSString *fromUserNameForChat = dictionary[YCUserFriendRequest__SenderID_KEY];
    
    AVQuery *query = [AVUser query];
    [query whereKey:CARED_LEANCLOUD_USER_userNameForChat equalTo:fromUserNameForChat];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!objects) {
            return ;
        }
        
        AVUser *senderUser = [objects firstObject];
        [self.requestListDic removeObjectForKey:senderUser.username];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestReceivedRequestFeedBackWithUser:passed:)]) {
//            [self.delegate userFriendRequestReceivedRequestFeedBackWithUser:senderUser  passed:NO];
//        }
        
    }];
    
    
}
////将密码合成用户好友请求并发送给某个用户
- (void)sendFriendRequestToUser:(AVUser *)user withPassword:(NSString *)password {
    AVUser *currentUser = [AVUser currentUser];
    NSString *senderUserNameForChat = currentUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *receiverUserNameForChat = user[CARED_LEANCLOUD_USER_userNameForChat];
    
    NSString *requestMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",senderUserNameForChat,YCUserFriendRequest_LineBreakingFlag,receiverUserNameForChat,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_WantToAddFriend,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_PasswordYES,YCUserFriendRequest_LineBreakingFlag,password];
    
    self.client = [[AVIMClient alloc] init];
    [self.client openWithClientId:senderUserNameForChat callback:^(BOOL succeeded, NSError *error) {
        [self.client createConversationWithName:@"friendRequest" clientIds:@[receiverUserNameForChat] callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:requestMessage attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestSendingRequestSuccessedToUser:andPassword:)]) {
                        [self.delegate userFriendRequestSendingRequestSuccessedToUser:user andPassword:password];
                    }
                } else {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestSendingRequestFailureToUser:andPassword:)]) {
                        [self.delegate userFriendRequestSendingRequestFailureToUser:user andPassword:password];
                    }
                }
            }];
        }];
    }];
}

- (void)feedBackYESToUser:(AVUser *)user {
    
    AVUser *currentUser = [AVUser currentUser];
    NSString *senderUserNameForChat = currentUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *receiverUserNameForChat = user[CARED_LEANCLOUD_USER_userNameForChat];
    
    NSString *requestMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",senderUserNameForChat,YCUserFriendRequest_LineBreakingFlag,receiverUserNameForChat,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_FeedBackRequestYES,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_PasswordNO,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_NOPasswordPlaceHolder];
    
    self.client = [[AVIMClient alloc] init];
    [self.client openWithClientId:senderUserNameForChat callback:^(BOOL succeeded, NSError *error) {
        [self.client createConversationWithName:@"friendRequest" clientIds:@[receiverUserNameForChat] callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:requestMessage attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[YCUserFriendsManager sharedFriendsManager] addFriend:user];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestFeedBackYESTOUserSucceed:)]) {
                        [self.delegate userFriendRequestFeedBackYESTOUserSucceed:user];
                    }
                    
                } else {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestFeedBackYESTOUserFailure:)]) {
                        [self.delegate userFriendRequestFeedBackYESTOUserFailure:user];
                    }
                    
                }
            }];
        }];
    }];
    [self.requestListDic removeObjectForKey:user.username];
}

- (void)feedBackNOToUser:(AVUser *)user {
    
    AVUser *currentUser = [AVUser currentUser];
    NSString *senderUserNameForChat = currentUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *receiverUserNameForChat = user[CARED_LEANCLOUD_USER_userNameForChat];
    
    NSString *requestMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",senderUserNameForChat,YCUserFriendRequest_LineBreakingFlag,receiverUserNameForChat,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_FeedBackRequestNO,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_PasswordNO,YCUserFriendRequest_LineBreakingFlag,YCUserFriendRequest_NOPasswordPlaceHolder];
    
    self.client = [[AVIMClient alloc] init];
    [self.client openWithClientId:senderUserNameForChat callback:^(BOOL succeeded, NSError *error) {
        [self.client createConversationWithName:@"friendRequest" clientIds:@[receiverUserNameForChat] callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:requestMessage attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestFeedBackNOTOUserSucceed:)]) {
                        [self.delegate userFriendRequestFeedBackYESTOUserSucceed:user];
                    }
                    
                } else {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendRequestFeedBackNOTOUserFailure:)]) {
                        [self.delegate userFriendRequestFeedBackYESTOUserFailure:user];
                    }
                    
                }
            }];
        }];
    }];
    [self.requestListDic removeObjectForKey:user.username];
}

- (NSMutableDictionary *)requestListDic {
    if (!_requestListDic) {
        _requestListDic = [NSMutableDictionary dictionary];
    }
    return _requestListDic;
}

@end
