//
//  YCUserFriendsManager.m
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <AVOSCloudIM.h>
#import "YCUserFriendsManager.h"
#import "YCUserDefines.h"

@interface YCUserFriendsManager ()

@property (nonatomic,strong) NSMutableArray *allFriendArray;

@end

@implementation YCUserFriendsManager

+ (instancetype)sharedFriendsManager {
    static YCUserFriendsManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
        
        [manager reloadAllFriends];
        
    });
    return manager;
}

- (NSArray *)reloadAllFriends {
    AVUser *currentUser = [AVUser currentUser];
    NSArray *friendListArray = currentUser[@"friends"];
    if (friendListArray.count == 0) {
        return nil;
    }
    
    [self.allFriendArray removeAllObjects];
    [self.allFriendArray addObjectsFromArray:friendListArray];
    return friendListArray;
}


- (NSMutableArray *)allFriendArray{
    if (!_allFriendArray) {
        _allFriendArray = [NSMutableArray array];
    }
    return _allFriendArray;
}
@end
