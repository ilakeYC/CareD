



//
//  Green_RCUserManage.m
//  CareD
//
//  Created by 慈丽娟 on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "Green_RCUserManage.h"
@interface Green_RCUserManage ()
@property (nonatomic, strong) NSMutableArray * rcUserAllArray;
@end

@implementation Green_RCUserManage

+(instancetype) shareRCUserManage
{
    static Green_RCUserManage * rcuserManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rcuserManage = [[Green_RCUserManage alloc]init];
    });
    return rcuserManage;
}

// 外界获取到信息数组

- (NSArray *)getAllRCUserInforArray
{
    return self.rcUserAllArray;
}
//  添加数组信息
- (void)setUserInforArrayWithRCUserInfor:(RCUserInfo *)userInfor
{
//     添加第一个元素时
    if (self.rcUserAllArray.count == 0) {
        [self.rcUserAllArray addObject:userInfor];
    }
    for (int i = 0; i < self.rcUserAllArray.count; i ++) {
        RCUserInfo * rcuserInfor = self.rcUserAllArray[i];
        if ([userInfor.userId isEqualToString:rcuserInfor.userId]) {
            [self.rcUserAllArray removeObject:rcuserInfor];
//             重新添加
            [self.rcUserAllArray addObject:userInfor];
        }else{
            [self.rcUserAllArray addObject:userInfor];
        }
    }
}


// 通过userID 查找user
- (RCUserInfo *)findRCUserInforByUserID:(NSString *)userID
{
    RCUserInfo * requestUser = nil;
    for (RCUserInfo * userInfor in self.rcUserAllArray) {
        if ([userID isEqualToString:userInfor.userId]) {
            requestUser = userInfor;
        }
    }
    return requestUser;
}


- (NSMutableArray *)rcUserAllArray
{
    if (!_rcUserAllArray) {
        self.rcUserAllArray = [NSMutableArray array];
    }
    return _rcUserAllArray;
}
@end
