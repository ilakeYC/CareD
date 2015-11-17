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
        
//        [manager reloadAllFriends];
        
    });
    return manager;
}

- (NSArray *)reloadAllFriends {
    AVUser *currentUser = [AVUser currentUser];
//    [currentUser refresh];
    NSLog(@"1");
    NSArray *friendUserNameArray = currentUser[@"friends"];
    if (friendUserNameArray.count == 0 || !friendUserNameArray) {
        return nil;
    }
//    NSMutableArray *friendListArray = [NSMutableArray array];
//    for (NSString *userName in friendUserNameArray) {
//        NSLog(@".>>%@",userName);
//        [friendListArray addObject:[self searchFriendByUserNameAndReturn:userName]];
//        
//    }
    NSLog(@"2");
    return friendUserNameArray;
}

- (void)searchFriendByNickName:(NSString *)nickName {
    AVQuery *query = [AVUser query];
    [query whereKey:@"nickName" containsString:nickName];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByNickNameStarted)]) {
        [self.delegate userFriendsManagerFriendSearchByNickNameStarted];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        AVUser *currentUser = [AVUser currentUser];
        NSMutableArray *array = [NSMutableArray arrayWithArray:objects];
        if (objects) {
            BOOL flag = NO;
            for (AVUser *user in objects) {
                if ([user.username isEqualToString:currentUser.username]) {
                    flag = YES;
                    currentUser = user;
                }
            }
            if (flag) {
                [array removeObject:currentUser];
            }
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByNickName:complete:)]) {
            [self.delegate userFriendsManagerFriendSearchByNickName:nickName complete:array];
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

- (void)searchFriendByUserName:(NSString *)userName result:(void (^)(AVUser *))handel {
    AVQuery *query = [AVUser query];
    [query whereKey:@"username" equalTo:userName];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userFriendsManagerFriendSearchByUserNameStarted)]) {
        [self.delegate userFriendsManagerFriendSearchByUserNameStarted];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects) {
            AVUser *user = [objects firstObject];
            
            handel(user);
            
            
        }
        
    }];
}
- (AVUser *)searchFriendByUserNameAndReturn:(NSString *)userName {
    
    AVQuery *query = [AVUser query];
    [query whereKey:@"username" equalTo:userName];
    NSArray *result = [query findObjects];
    
    if (result) {
        AVUser *user = [result firstObject];
        return user;
    }
    return nil;
    
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
        [currentUser setObject:@[user.username] forKey:CARED_LEANCLOUD_USER_friendList];
    } else {
        [self.allFriendArray addObject:user.username];
        [currentUser setObject:self.allFriendArray forKey:CARED_LEANCLOUD_USER_friendList];
    }
    
//    NSArray *array = user[CARED_LEANCLOUD_USER_friendList];
//    if (array.count == 0 || !array) {
//        [user setObject:@[currentUser] forKey:CARED_LEANCLOUD_USER_friendList];
//    } else {
//        NSMutableArray *friendArray = [NSMutableArray arrayWithArray:array];
//        [friendArray addObject:currentUser];
//        [user setObject:friendArray forKey:CARED_LEANCLOUD_USER_friendList];
//    }
//    [user save];
    [currentUser save];
    
    return YES;
}

- (BOOL)userIsFriend:(AVUser *)user {
    for (NSString *userNmae in self.allFriendArray) {
        if ([userNmae isEqualToString:user.username]) {
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
