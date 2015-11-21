//
//  Green_FriendSettingTableViewController.h
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/14.
//  Copyright © 2015年 clj. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@protocol Green_FriendSettingTableViewControllerDelegate <NSObject>
// 清除聊天记录后更新UI
- (void)clearMessages;

@end

@interface Green_FriendSettingTableViewController : UITableViewController

@property (nonatomic, strong) RCUserInfo * userInfor;

// 设置代理判断是否执行 清除聊天界面操作， 若清除， 代理方法内做处理， 避免页面中还有数据
@property (nonatomic, assign) id <Green_FriendSettingTableViewControllerDelegate> delegate;



@end
