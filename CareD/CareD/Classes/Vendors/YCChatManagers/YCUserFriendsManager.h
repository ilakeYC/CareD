//
//  YCUserFriendsManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCUserFriendsManager : NSObject

+ (instancetype)sharedFriendsManager;

- (NSArray *)reloadAllFriends;

@end
