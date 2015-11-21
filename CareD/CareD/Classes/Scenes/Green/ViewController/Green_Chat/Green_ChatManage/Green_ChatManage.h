//
//  Green_ChatManage.h
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/13.
//  Copyright © 2015年 clj. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface Green_ChatManage : RCConversationViewController



//// 多个用户的字典。 key值是不同用户的ID， Value是不同用户对应的好友消息数字典 （避免不同用户使用同一手机出现的好友消息冲突问题）
//- (void)setAllUserCountDictionaryWithDictionary:(NSDictionary *)dicionary; // AppDelegate 中使用
//- (NSDictionary *)getAllAllUserCountDictionary;                            // AppDelegate 中使用


//  获取某个用户单个好友的好友消息数 （直接从plist 文件中取）
+ (NSNumber *)getOneUserFriendMessageByUserID:(NSString *)userID targetID:(NSString *)targetID;  // 用户聊天界面viewWillAppear 使用
// 修改某个用户单个好友的好友信息数 （直接对plist 文件修改）
+ (void)setOneUserFriendMessageByUserID:(NSString *)userID targetID:(NSString *)targetID withCount:(NSNumber *)count; // 用户聊天界面viewDidDisAppear 使用



#pragma mark 根据聊天到少获取前 5 名的好友
+ (NSArray *) findFiveFriends;

@end
