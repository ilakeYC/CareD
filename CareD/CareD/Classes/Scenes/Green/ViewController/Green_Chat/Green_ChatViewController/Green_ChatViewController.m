

//
//  Green_ChatViewController.m
//  Green_RongYun_Demo
//
//  Created by 慈丽娟 on 15/11/16.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_ChatViewController.h"


@interface Green_ChatViewController ()<Green_FriendSettingTableViewControllerDelegate, RCIMReceiveMessageDelegate , RCConnectionStatusChangeDelegate,  RCIMConnectionStatusDelegate>
{
    NSInteger allCount;  // 当前聊天页面用户发送成功的消息， 在此页面 同当前user 聊天的好友发来的消息 （两个user所有息）
}

@end

@implementation Green_ChatViewController



- (void)loadView
{
    [super loadView];
    //     圆形头像
    [self setMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
}

- (void)viewDidLoad{
    [super viewDidLoad];

#warning  mark   登陆状态设置 代理
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    
    //     在init 方法中失败， 除了修改头像之外剩下的设置都在viewDidLoad 里或者之后
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    //     开启右上角和右下角未读个数icon。
    self.enableUnreadMessageIcon = YES;
    //    默认No,如果Yes, 当消息不在最下方时显示 右下角新消息数图标 （成功）
    self.enableNewComingMessageIcon = YES;
    //    是否开启语音消息连读，设置为Yes，播放语音消息时 会连续播放下面所有收到的未读语音消息
    self.enableContinuousReadUnreadVoice = YES;
    //    *  消息免通知，默认是NO
//    [RCIM sharedRCIM].disableMessageNotificaiton = NO;
}

/**
 *  打开地理位置。开发者可以重写，自己根据经纬度打开地图显示位置。默认使用内置地图
 *
 *  @param locationMessageContent 位置消息
 */
- (void)presentLocationViewController:(RCLocationMessage *)locationMessageContent
{
    Green_MapViewViewController * mapView = [Green_MapViewViewController shareMapViewController];
    mapView.cllocation2D = locationMessageContent.location;
    [self.navigationController pushViewController:mapView animated:YES];
}


#pragma mark rightBarButtonItemAction 点击事件
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    Green_FriendSettingTableViewController * view = [[Green_FriendSettingTableViewController alloc]initWithStyle:UITableViewStylePlain];
    view.userInfor = [[Green_RCUserManage shareRCUserManage]findRCUserInforByUserID:self.targetId];
    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
    
}

#pragma mark 头像点击事件  userId 用户的ID

- (void)didTapCellPortrait:(NSString *)userId
{
    if ([self.targetId isEqualToString:userId]) {
//         好友信息页面
        Green_FriendSettingTableViewController * setVC = [[Green_FriendSettingTableViewController alloc]initWithStyle:UITableViewStylePlain];
        setVC.userInfor = [[Green_RCUserManage shareRCUserManage]findRCUserInforByUserID:self.targetId];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
    AVUser * user = [AVUser currentUser];
    NSString *userNameForToken = user[CARED_LEANCLOUD_USER_userNameForChat];
    if ([userId isEqualToString:userNameForToken]) {
//         用户信息页面
        HYUserInfoViewController * userInforVC = [HYUserInfoViewController new];
        UINavigationController * rootNC = [[UINavigationController alloc] initWithRootViewController:userInforVC];
        rootNC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action: @selector(userleftButtonAction:)];
        
        [self showDetailViewController:rootNC sender:nil];
    }
}


#pragma mark 返回按钮点击事件
- (void)friendleftButtonAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userleftButtonAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 实现 Green_FriendSettingTableViewControllerDelegate 代理方法
// 清除聊天记录后更新UI
- (void)clearMessages{
    [self.conversationDataRepository removeAllObjects];
    [self.conversationMessageCollectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [RCIM sharedRCIM].receiveMessageDelegate = self;
}


/**
// 接收消息到消息后执行。
// 
// @param message 接收到的消息。
// @param left    剩余消息数.
// */
//
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if (![message.senderUserId isEqualToString:self.targetId]) {
        [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserNameForChat:message.senderUserId result:^(AVUser *user) {
            if (user) {
                [[UnreadTipView prepareNotifaction] setUserNickName:user[@"nickName"]];
                
            }
            
        }];
    }
    NSLog(@" message = %@", message.senderUserId);
//      如果发送消息的好友与当前好友是同一个，消息加1
    if ([self.targetId isEqualToString:message.senderUserId]) {
        allCount ++;
    }
}


#pragma mark 聊天记录统计模块
#pragma mark 消息发送完成后触发
- (void)didSendMessage:(NSInteger)stauts content:(RCMessageContent *)messageCotent
{
    //  没增加一条消息，通过TargetID 获取单例中的聊天记录，并修改
    allCount ++;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //     获取聊天数目,
    NSNumber * allCountNumber = [Green_ChatManage getOneUserFriendMessageByUserID:@"1" targetID:self.targetId];
    allCount = allCountNumber.integerValue;
    
   
    // 取出图片
    NSString * key =@"GreenFriendBackImage";
    key = [key stringByAppendingFormat:@"%@",self.targetId];
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    //    设置聊天背景 ，设置为图片
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    UIImageView * test = [[UIImageView alloc]initWithFrame:self.conversationMessageCollectionView.bounds];
    test.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%@",number]];
    self.conversationMessageCollectionView.backgroundView = test;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (allCount == 0) {
        return;
    }
    NSNumber * number = [NSNumber numberWithInteger:(allCount )];
    NSLog(@"Green -----------好友 %@ 的聊天数目 %@", self.targetId,number);
    if (self.targetId){
        [Green_ChatManage setOneUserFriendMessageByUserID:@"1" targetID:self.targetId withCount:number];
    }
}



#warning mark 连接融云状态 ，连接融云断线的原因在此监测
#pragma mark 判断 网络状态
- (void)onConnectionStatusChanged:(RCConnectionStatus)status
{
    NSLog(@"连接融云状态 = %ld",(long)status);
    
//  重新登陆 ,需要获取当前用户的token
//  [RCIM sharedRCIM]connectWithToken:<#(NSString *)#> success:<#^(NSString *userId)successBlock#> error:<#^(RCConnectErrorCode status)errorBlock#> tokenIncorrect:<#^(void)tokenIncorrectBlock#>
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
}

- (void)dealloc
{
    [RCIM sharedRCIM].receiveMessageDelegate = nil;
}
@end
