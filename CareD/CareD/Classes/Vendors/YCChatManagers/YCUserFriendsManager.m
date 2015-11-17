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
    [currentUser refresh];
    NSArray *friendListArray = currentUser[@"friends"];
    if (friendListArray.count == 0 || !friendListArray) {
        return nil;
    }
    
    [self.allFriendArray removeAllObjects];
    [self.allFriendArray addObjectsFromArray:friendListArray];
    return friendListArray;
}

- (void)searchFriendByNickName:(NSString *)nickName {
    AVQuery *query = [AVUser query];
    [query whereKey:@"nickName" containsString:nickName];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByNickNameStarted)]) {
        [self.delegate userFriendsManagerFriendSearchByNickNameStarted];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByNickName:complete:)]) {
            [self.delegate userFriendsManagerFriendSearchByNickName:nickName complete:objects];
        }
        
    }];
}

- (void)searchFriendByUserName:(NSString *)userName {
    AVQuery *query = [AVUser query];
    [query whereKey:@"username" equalTo:userName];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByUserNameStarted)]) {
        [self.delegate userFriendsManagerFriendSearchByUserNameStarted];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByUserName:complete:)]) {
            [self.delegate userFriendsManagerFriendSearchByUserName:userName complete:objects];
        }
        
    }];
}


- (void)searchFriendByUserNameForScan:(NSString *)userNameForScan {
    AVQuery *query = [AVUser query];
    [query whereKey:CARED_LEANCLOUD_USER_userNameForScan equalTo:userNameForScan];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByUserNameForScanStarted)]) {
        [self.delegate userFriendsManagerFriendSearchByUserNameForScanStarted];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByUserNameForScan:complete:)]) {
            [self.delegate userFriendsManagerFriendSearchByUserNameForScan:userNameForScan complete:objects];
        }
    }];
}

- (BOOL)addFriend:(AVUser *)user {
    AVUser *currentUser = [AVUser currentUser];
    if (![self reloadAllFriends] || [self reloadAllFriends].count == 0) {
        [currentUser setObject:@[user] forKey:CARED_LEANCLOUD_USER_friendList];
    } else {
        [self.allFriendArray addObject:user];
        [currentUser setObject:self.allFriendArray forKey:CARED_LEANCLOUD_USER_friendList];
    }
    
    NSArray *array = user[CARED_LEANCLOUD_USER_friendList];
    if (array.count == 0 || !array) {
        [user setObject:@[currentUser] forKey:CARED_LEANCLOUD_USER_friendList];
    } else {
        NSMutableArray *friendArray = [NSMutableArray arrayWithArray:array];
        [friendArray addObject:currentUser];
        [user setObject:friendArray forKey:CARED_LEANCLOUD_USER_friendList];
    }
    [user save];
    [currentUser save];
    
    return YES;
}

- (BOOL)userIsFriend:(AVUser *)user {
    for (AVUser *friend in self.allFriendArray) {
        if ([friend.username isEqualToString:user.username]) {
            return YES;
        }
    }
    return NO;
}


- (NSMutableArray *)allFriendArray{
    if (!_allFriendArray) {
        _allFriendArray = [NSMutableArray array];
    }
    return _allFriendArray;
}
@end
