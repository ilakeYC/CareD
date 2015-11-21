//
//  Green_RCUserManage.h
//  CareD
//
//  Created by 慈丽娟 on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//


/*
 用户 ，好友信息数据管理
 */
#import <Foundation/Foundation.h>

@interface Green_RCUserManage : NSObject


+(instancetype) shareRCUserManage;

// 外界获取到信息数组

- (NSArray *)getAllRCUserInforArray;
//  添加数组信息
- (void)setUserInforArrayWithRCUserInfor:(RCUserInfo *)userInfor;
// 通过userID 查找user
- (RCUserInfo *)findRCUserInforByUserID:(NSString *)userID;

@end
