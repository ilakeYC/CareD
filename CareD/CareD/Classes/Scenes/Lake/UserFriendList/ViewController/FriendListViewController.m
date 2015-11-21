//
//  FriendListViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

/**
 未读消息类为：YCUreadListView
 其属性：(NSInteger)numberOfUnread 可以设置未读好友数量，他会自动显示或消失
 */


#import "FriendListViewController.h"
#import "FriendListView.h"
#import "YCFuncListView.h"
#import "TwoCodeView.h"

@interface FriendListViewController ()<YCUserImageManagerDelegate, UserImageViewDelegate,YCFuncListViewDelegate,YCUnreadListViewDelegate,YCFriendRequestListButtonDelegate,YCUserFriendRequestManagerDelegate,YCFriendRequestListButtonDelegate, GreenScannerViewDelegate,HYLocationManagerDelegate, RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>

@property (nonatomic,strong) FriendListView *friendListView;




@property (nonatomic,strong) UIView *buttonListView;
@property (nonatomic,strong) UIButton *circleListButton;
@property (nonatomic,strong) UIButton *tableListButton;
@property (nonatomic,strong) UIButton *funcListButton;

@property (nonatomic,strong) Green_ScannerView *scannerView;


@property (nonatomic,strong) YCFuncListView *funcListView;

// 所有好友的信息AVUser
@property (nonatomic, strong) NSMutableArray * friendArray;
// 当前用户、好友的所有信息RCUserInfo
@property (nonatomic, strong) NSMutableArray * RCUserInfoArray;

// 当前的RCUserInfor ，用于推送
@property (nonatomic, strong) RCUserInfo * rcUserInfor;


@property (nonatomic,strong) TwoCodeView *twoCodeView;

@end

@implementation FriendListViewController

- (void)loadView {
    self.friendListView = [[FriendListView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.friendListView;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    logoImageView.frame = CGRectMake(0, 0, 20*4.30252101, 20);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoImageView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置融云数据源代理
    [RCIM sharedRCIM].userInfoDataSource = self;
    
    [self makeButtonList];
    self.scannerView = [[Green_ScannerView alloc]init];
    self.scannerView.delegate = self;
    
    self.friendListView.userImageView.delegate = self;
    //开始下载用户头像
    [YCUserImageManager sharedUserImage].delegate = self;
    [[YCUserImageManager sharedUserImage] getCurrentUserImageURL];
    
   
    
    
    self.circleListButton.enabled = NO;
    
    self.funcListView = [YCFuncListView new];
    self.funcListView.delegate = self;
    self.friendListView.unreadListView.delegate = self;
    self.friendListView.friendRequestButton.delegate = self;
    
    [HYLocationManager sharedHYLocationManager].delegate = self;
    
    ///接收好友请求通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"收到请求" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        self.friendListView.friendRequestButton.hasRequest = YES;
    }];
    
    
    ///开始定位
    [[HYLocationManager sharedHYLocationManager] start];
    //开始获得天气
    [self getDiskUserWeather];
    
    
    
    
#warning ---------------------------------------------
    [self loadFriend];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFriend) name:@"addFriend" object:nil];
}


///加载所有好友
- (void)loadFriend {
    
    NSArray *userNameArray = [[YCUserFriendsManager sharedFriendsManager] reloadAllFriends];
    if (self.friendArray.count > 0) {
        [self.friendArray removeAllObjects];
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *userName in userNameArray) {
        [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserName:userName result:^(AVUser *user) {
            
            [tempArray addObject:user];
            [self.friendArray addObject:user];
            NSLog(@"%@",user.username);
            self.friendListView.theFriendListView.friendArray = tempArray;
            
            //             获取当前用户，好友的信息 RCUserInfo
            [self getAllRCuerInforArray];
            
        }];
    }
    
}

- (void)hasUnRead {
     self.friendListView.unreadListView.numberOfUnread = [self getUnReadFriendCount];
}

- (void)getDiskUserWeather {
    
    UserWeather *weather = [YHYWeatherManger sharedYHYWeatherManager].currentUserWeather;
    if (!weather.weather) {
        return;
    }
    
    self.friendListView.locationLabel.text = [NSString stringWithFormat:@"%@,%@",weather.city,weather.area];
    self.friendListView.weatherLabel.text = weather.tempWeather;
    self.friendListView.airLabel.text = [NSString stringWithFormat:@"空气质量:%@",weather.air];
    
}



- (void)viewDidAppear:(BOOL)animated {

    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [super viewDidAppear:animated];
    [self.friendListView.theFriendListView loadFriendCaredTop5];
    [self hasUnRead];
    
    [[YCUserImageManager sharedUserImage] getImageWithUser:[AVUser currentUser] handel:^(UIImage *image) {
        self.friendListView.userImageView.image = image;
    }];
    
#pragma mark 在这里添加未读
    self.friendListView.unreadListView.numberOfUnread = [self getUnReadFriendCount];
    
    __block typeof(self) tempSelf = self;
    self.friendListView.theFriendListView.selectedCollectionViewCellBlock = ^(Green_ChatViewController *GCVC) {
        
        [tempSelf.navigationController pushViewController:GCVC animated:YES];
        
    };
    
    //推出好友详情界面
    self.friendListView.theFriendListView.selectedTableViewCellBlock = ^(HYFriendInfoViewController *friendInfoVC){
        
        [tempSelf.navigationController pushViewController:friendInfoVC animated:YES];
    };
    

    if ([[YCUserFriendRequestManager sharedUserFriendRequestManager] requestListDic].count != 0) {
        self.friendListView.friendRequestButton.hasRequest = YES;
    } else {
        self.friendListView.friendRequestButton.hasRequest = NO;
    }
    
    
#warning ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
//    NSArray *userNameArray = [[YCUserFriendsManager sharedFriendsManager] reloadAllFriends];
//    if (self.friendArray.count > 0) {
//        [self.friendArray removeAllObjects];
//    }
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (NSString *userName in userNameArray) {
//        [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserName:userName result:^(AVUser *user) {
//            
//            [tempArray addObject:user];
    
//            [self.friendArray addObject:user];
//            NSLog(@"%@",user.username);
//            self.friendListView.theFriendListView.friendArray = tempArray;
//            
//            //             获取当前用户，好友的信息 RCUserInfo
//            [self getAllRCuerInforArray];
//            
//        }];
//    }
    //    self.friendListView.theFriendListView.friendArray = [[YCUserFriendsManager sharedFriendsManager] reloadAllFriends];
    
}




#pragma mark 获取融云需要的RCUserInfor
- (void)getAllRCuerInforArray
{
    
    // 当前用户
    AVUser * myUser = [AVUser currentUser];
    NSString *myuserNameForToken = myUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *myuserName = myUser[@"nickName"];
    
    [[YCUserImageManager sharedUserImage]getImageUrlWithUser:myUser handel:^(NSString *URL) {
        RCUserInfo * userInfor = [[RCUserInfo alloc] initWithUserId:myuserNameForToken name:myuserName portrait:URL];
        //             放到当前保存 RCUserInfo 的数组中
        [self.RCUserInfoArray addObject:userInfor];

        //             保存到单例数组中
        [[Green_RCUserManage shareRCUserManage]setUserInforArrayWithRCUserInfor:userInfor];
    }];
    
    //     所有好友
    for (int i = 0; i < self.friendArray.count; i ++) {
        AVUser * user = self.friendArray[i];
        NSString *userNameForToken = user[CARED_LEANCLOUD_USER_userNameForChat];
        NSString * userName = user[@"nickName"];
        if (self.RCUserInfoArray.count >1  ) {
            [self.RCUserInfoArray removeAllObjects];
        }
        [[YCUserImageManager sharedUserImage]getImageUrlWithUser:user handel:^(NSString *URL) {
            RCUserInfo * userInfor = [[RCUserInfo alloc] initWithUserId:userNameForToken name:userName portrait:URL];
            //             放到当前保存 RCUserInfo 的数组中
            [self.RCUserInfoArray addObject:userInfor];
            //             保存到单例数组中
            [[Green_RCUserManage shareRCUserManage]setUserInforArrayWithRCUserInfor:userInfor];
        }];
    }
}


#pragma mark RCIMUserInfoDataSource  通过ID获取用户信息 融云数据源方法
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    if (self.RCUserInfoArray.count == 0) {
        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!融云数据源为空");
        return;
    }
    
    //     好友
    for (int i = 0; i < self.RCUserInfoArray.count; i ++) {
        RCUserInfo * userInfor = self.RCUserInfoArray[i];
        if ([userId isEqualToString:userInfor.userId]) {
            completion(userInfor);
        }
    }
}



#pragma mark Green  获取未读信息 好友数
- (NSInteger )getUnReadFriendCount
{
    
    NSInteger count = 0;
    //     获取当前user 的所有好友
    NSArray *array = [[YCUserFriendsManager sharedFriendsManager] reloadAllFriends];
    for (NSString *friendID  in array) {
        //   获取生成Token ID
        NSString *nameForScan = [[YCUserManager sharedUserManager] stringByEncryptionFromString:friendID];
        NSString *nameForChat = [[YCUserManager sharedUserManager] stringByEncryptionFromString:nameForScan];
        //   获取未读信息消息数
        NSInteger unReaderMessageCount = [[RCIMClient sharedRCIMClient]getUnreadCount:ConversationType_PRIVATE targetId:nameForChat];
        if (unReaderMessageCount > 0) {
            count ++;
        }
    }
    return count;
}


#pragma mark 接收到消息的监听方法 （在聊天页面中也实现了这个监听方法， 弹出提示栏， 此控制器实现这个方法用来刷新未读好友数）
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.rcUserInfor.userId = message.senderUserId;
//     同一用户只社会自一次就好
    if ([self.rcUserInfor.userId isEqualToString:message.senderUserId]) {
        return;
    }
dispatch_async(dispatch_get_main_queue(), ^{
    [self.friendListView.unreadListView setNumberOfUnread:[self getUnReadFriendCount]];
});
}


//- 添加按钮列表(导航栏上三个按钮)
- (void)makeButtonList {
    self.buttonListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.382, 30)];
    //    self.buttonListView.backgroundColor = [UIColor whiteColor];
    self.circleListButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.circleListButton setImage:[UIImage imageNamed:@"circleList"] forState:(UIControlStateNormal)];
    [self.circleListButton setTintColor:[UIColor whiteColor]];
    self.circleListButton.frame = CGRectMake(0, 0, 30, 30);
    [self.circleListButton addTarget:self action:@selector(changeViewFunc:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonListView addSubview:self.circleListButton];
    
    self.tableListButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.tableListButton setImage:[UIImage imageNamed:@"tableList"] forState:(UIControlStateNormal)];
    [self.tableListButton setTintColor:[UIColor whiteColor]];
    self.tableListButton.frame = CGRectMake((self.buttonListView.frame.size.width - 30) / 2 - 10, 0, 30, 30);
    [self.tableListButton addTarget:self action:@selector(changeViewFunc:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.buttonListView addSubview:self.tableListButton];
    
    self.funcListButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.funcListButton setImage:[UIImage imageNamed:@"funcButton"] forState:(UIControlStateNormal)];
    [self.funcListButton setTintColor:[UIColor whiteColor]];
    self.funcListButton.frame = CGRectMake(self.buttonListView.frame.size.width - 30, 0, 30, 30);
    [self.buttonListView addSubview:self.funcListButton];
    
    [self.funcListButton addTarget:self action:@selector(showFuncList) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonListView];
}

- (void)changeViewFunc:(UIButton *)sender {
    if (sender == self.tableListButton) {
        [self.friendListView.theFriendListView showTableListView];
        sender.enabled = NO;
        self.circleListButton.enabled = YES;
    } else if (sender == self.circleListButton) {
        [self.friendListView.theFriendListView showCircleListView];
        sender.enabled = NO;
        self.tableListButton.enabled = YES;
    }
}

//导航栏上第三个按钮点击
- (void)showFuncList {
    [self.funcListView showButtonList];
}

#pragma mark - button列表点击
//按钮列表代理
- (void)funcListViewTouchedButtonAtIndex:(NSInteger)index {
    if (index == 0) {
        
        YCSearchUsersViewController *searchUsersVC = [YCSearchUsersViewController new];
        UINavigationController *searchUsersNC = [[UINavigationController alloc] initWithRootViewController:searchUsersVC];
        //推出查找联系人
        [self presentViewController:searchUsersNC animated:YES completion:^{
            
        }];
        
    } else if (index == 1) {
        [self.scannerView showScannerView];
    } else if (index == 2) {
        self.twoCodeView = [TwoCodeView new];
        [self.twoCodeView showView];
    } else if (index == 3) {
        [self loadFriend];
    }
}

#pragma mark 二维码的扫描代理
- (void)scannerViewDidFinishedScan:(NSString *)string
{
    //     string 就是扫描后输出的string
    NSLog(@"scnnser = %@", string);
    NSString *userNameForChat = [[YCUserManager sharedUserManager] stringByEncryptionFromString:string];
    
    [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserNameForChat:userNameForChat result:^(AVUser *user) {
        ScannerAddFriendController *scannerAddFriendVC = [ScannerAddFriendController new];
        UINavigationController *scannerAddFriendNC = [[UINavigationController alloc] initWithRootViewController:scannerAddFriendVC];
        scannerAddFriendVC.user = user;
        [self presentViewController:scannerAddFriendNC animated:YES completion:^{
        }];
    }];
    
}

#pragma mark - YCUserImageManager delegate
- (void)userImageManagerCurrentUserImageDownComplete:(UIImage *)image {
    //    [self.friendListView.userImageView setImage:image];
}
- (void)userImageManagerCurrentUserImageURLDownComplete:(NSString *)url {
    [self.friendListView.userImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Icon-512"]];
}

#pragma mark - userImageView delegate
- (void)userImageViewTouchUpInSide {
    NSLog(@"\n%d,\n%s\n",__LINE__,__FUNCTION__);
    NSLog(@"用户头像被点击");
    
    UINavigationController *userInfoNC = [[UINavigationController alloc] initWithRootViewController:[HYUserInfoViewController new]];
    
    [self presentViewController:userInfoNC animated:YES completion:^{
        
    }];
    
}


#pragma mark - 未读信息点击事件
- (void)unreadListViewTouchedUpInside:(YCUnreadListView *)unreadListView {
    
    Green_ListViewController *conList = [[Green_ListViewController alloc] initWithDisplayConversationTypes:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION),@(ConversationType_PRIVATE)] collectionConversationType:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
    
    [self.navigationController pushViewController:conList animated:YES];
}

- (void)friendRequestListButtonTouchUpInside {
    [self.navigationController pushViewController:[FriendRequestsListViewController new] animated:YES];
}

#pragma mark - 开始获得用户地理位置
- (void)userLocationByCity:(NSString *)city area:(NSString *)area {
    [[YHYWeatherManger sharedYHYWeatherManager] requestWeatherByCityName:city area:area block:^(UserWeather *model) {
        UserWeather *weather = model;
        self.friendListView.locationLabel.text = [NSString stringWithFormat:@"%@,%@",weather.city,weather.area];
        self.friendListView.weatherLabel.text = weather.tempWeather;
        self.friendListView.airLabel.text = [NSString stringWithFormat:@"空气质量:%@",weather.air];
        
    }];
}



#pragma mark 好友数组懒加载
- (NSMutableArray *)friendArray
{
    if (!_friendArray) {
        self.friendArray = [NSMutableArray array];
    }
    return _friendArray;
}

-(NSMutableArray *)RCUserInfoArray{
    if (!_RCUserInfoArray) {
        self.RCUserInfoArray = [NSMutableArray array];
    }
    return _RCUserInfoArray;
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addFriend" object:nil];
      [RCIM sharedRCIM].receiveMessageDelegate = nil;
}

@end
