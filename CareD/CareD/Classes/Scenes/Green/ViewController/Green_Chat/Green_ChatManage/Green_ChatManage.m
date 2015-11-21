


//
//  Green_ChatManage.m
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/13.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_ChatManage.h"
@interface Green_ChatManage ()

@end

@implementation Green_ChatManage

 // 用户聊天界面viewDidDisAppear 使用
//  获取某个用户单个好友的好友消息数 （直接从plist 文件中取）
+ (NSNumber *)getOneUserFriendMessageByUserID:(NSString *)userID targetID:(NSString *)targetID
{
       AVUser *currentUser = [AVUser currentUser];
       userID = currentUser.username;
//     从 NSUserDefaults 中获取数据存放到单例中
        NSMutableDictionary * maindic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Greencount"]];
//     当前用户的所有好友消息记录Count
        NSMutableDictionary * userDic = [maindic objectForKey:userID];
//     当前用户当前好友的所有消息
       NSNumber *count = [userDic objectForKey:targetID];
       return  count;
}


// 修改某个用户单个好友的好友信息数 （直接对plist 文件修改）
+ (void)setOneUserFriendMessageByUserID:(NSString *)userID targetID:(NSString *)targetID withCount:(NSNumber *)count
{
    
    AVUser *currentUser = [AVUser currentUser];
    userID = currentUser.username;
    
//     先取出总的信息
    NSMutableDictionary * mainDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Greencount"]];
#warning mark 取可变字典问题！！！！
//    取出当前用户的所有好友信息
    NSMutableDictionary * userDic = [NSMutableDictionary dictionaryWithDictionary:[mainDic objectForKey:userID]];
    
//     如果当前用户在所有字典中不存在， 创建user 字典
    if (userDic == nil) {
        NSMutableDictionary * newUseDic = [NSMutableDictionary dictionary];
        [newUseDic setObject:count forKey:targetID];
//     更新所有总的信息字典
        [mainDic setObject:newUseDic forKey:userID];
    }else{
        
//  更新当前用户好友消息字典
//         先删除
//        if ([userDic objectForKey:targetID]!= nil) {
//    [userDic removeObjectForKey:targetID];
//        }
    [userDic setObject:count forKey:targetID];
//     更新所有总的信息字典
    [mainDic setObject:userDic forKey:userID];
    }
 
//     更新本地
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: mainDic forKey:@"Greencount"];
}




#pragma mark 根据聊天到少获取前 5 名的好友id, 从前往后排。 (没有5个好友)
+ (NSArray *) findFiveFriends
{
//     取出当前用户的所有好友聊天信息
    AVUser *currentUser = [AVUser currentUser];
    //     先取出总的信息
    NSMutableDictionary * mainDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Greencount"]];
    //    取出当前用户的所有好友信息
    NSMutableDictionary * userDic = [mainDic objectForKey:currentUser.username];
    
    NSMutableArray *userNameCountArray = [NSMutableArray array];
    [userNameCountArray addObjectsFromArray:[userDic allKeys]];
    [userNameCountArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *user1 = (NSString *)obj1;
        NSString *user2 = (NSString *)obj2;
        NSNumber *user1Nn = userDic[user1];
        NSNumber *user2Nn = userDic[user2];
        return user1Nn.integerValue < user2Nn.integerValue;
        
    }];
    
    if (userNameCountArray.count <= 5) {
        return userNameCountArray;
    } else if (userNameCountArray.count>5) {
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:5];
        for (int x = 0; x < 5; x ++) {
            [resultArray addObject:userNameCountArray[x]];
        }
        return resultArray;
    }
    
    return userNameCountArray;
}


@end
