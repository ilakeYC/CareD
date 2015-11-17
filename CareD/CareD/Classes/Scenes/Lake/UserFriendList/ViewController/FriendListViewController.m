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

@interface FriendListViewController ()<YCUserImageManagerDelegate, UserImageViewDelegate,YCFuncListViewDelegate,YCUnreadListViewDelegate>

@property (nonatomic,strong) FriendListView *friendListView;




@property (nonatomic,strong) UIView *buttonListView;
@property (nonatomic,strong) UIButton *circleListButton;
@property (nonatomic,strong) UIButton *tableListButton;
@property (nonatomic,strong) UIButton *funcListButton;




@property (nonatomic,strong) YCFuncListView *funcListView;
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
    
    [self makeButtonList];
    
    self.friendListView.userImageView.delegate = self;
    //开始下载用户头像
    [YCUserImageManager sharedUserImage].delegate = self;
    [[YCUserImageManager sharedUserImage] getCurrentUserImageURL];
    
    
    
    self.circleListButton.enabled = NO;
    
    self.funcListView = [YCFuncListView new];
    self.funcListView.delegate = self;
    self.friendListView.unreadListView.delegate = self;
    

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    #pragma mark 在这里添加未读
    self.friendListView.unreadListView.numberOfUnread = 3;
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
//按钮列表代理
- (void)funcListViewTouchedButtonAtIndex:(NSInteger)index {
    if (index == 0) {
        
        YCSearchUsersViewController *searchUsersVC = [YCSearchUsersViewController new];
        UINavigationController *searchUsersNC = [[UINavigationController alloc] initWithRootViewController:searchUsersVC];
        //推出查找联系人
        [self presentViewController:searchUsersNC animated:YES completion:^{
            
        }];
        
    } else if (index == 1) {
        
    }
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
}


#pragma mark - 未读信息点击事件
- (void)unreadListViewTouchedUpInside:(YCUnreadListView *)unreadListView {
    
    
}

@end
