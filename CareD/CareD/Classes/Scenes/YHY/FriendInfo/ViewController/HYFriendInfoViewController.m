//
//  HYFriendInfoViewController.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYFriendInfoViewController.h"
#import "HYFriendView.h"

@interface HYFriendInfoViewController ()

@property (nonatomic, strong) HYFriendView *friendView;

@end

@implementation HYFriendInfoViewController

- (void)loadView
{
    //关闭自动嵌入（44）的高度效果
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.friendView = [[HYFriendView alloc] init];
    self.friendView.backgroundColor = [UIColor whiteColor];
    self.view = self.friendView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.friendView.sendMessageButton addTarget:self action:@selector(sendMessageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.friendView.nicknameLabel.text = self.user[@"nickName"];
    [[YCUserImageManager sharedUserImage] getImageWithUser:self.user handel:^(UIImage *image) {
        self.friendView.headImageView.image = image;
    }];
    
    userLocationModel *location = [[YCUserManager sharedUserManager] getLocationByUser:self.user];
    [[YHYWeatherManger sharedYHYWeatherManager] requestWeatherByCityName:location.city area:location.area block:^(UserWeather *model) {
        
        
        
        if ([model.weather isEqualToString:@"阴天"] || [model.weather isEqualToString:@"阴"]) {
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Cloudy"];
        }else if ([model.weather isEqualToString:@"多云"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Cloudy_small"];
        }else if ([model.weather isEqualToString:@"雾"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Fog"];
        }else if ([model.weather isEqualToString:@"大雨"] || [model.weather isEqualToString:@"阵雨"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Rain_big"];
        }else if ([model.weather isEqualToString:@"小雨"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Rain_small"];
        }else if ([model.weather isEqualToString:@"雪"] || [model.weather containsString:@"雪"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Snow"];
        }else if ([model.weather isEqualToString:@"晴"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Sunny"];
        }else if ([model.weather isEqualToString:@"霾"]){
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"mai"];
        } else if ([model.weather containsString:@"雹"]) {
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"yujiabingbao"];
        } else if ([model.weather isEqualToString:@"雨夹雪"]) {
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"yujiaxue"];
        } else if ([model.weather isEqualToString:@"雷阵雨"]) {
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"leizhenyu"];
        }
        else{
            self.friendView.weatherImageView.image = [UIImage imageNamed:@"Sunny"];
        }
        
        
       
        self.friendView.cityLabel.text = [NSString stringWithFormat:@"%@|%@",location.city,location.area];
        self.friendView.weatherLabel.text = model.weather;
        self.friendView.tempLabel.text    = model.temp;
        self.friendView.airLabel.text     = model.air;
        
        CGFloat distance = [[HYLocationManager sharedHYLocationManager] distanceBetweenOrderByOtherLatitude:location.latitude  longitude:location.longtitude];
        
        if (distance < 1000) {
            
            self.friendView.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f米",distance];
        } else if(distance >= 1000) {
            
            self.friendView.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f公里",distance / 1000];
            
        }
        
    }];
    

}

- (void)sendMessageButtonAction:(UIButton *)sender
{
    //     点击最近好友， 直接聊天
    Green_ChatViewController * chatVC = [[Green_ChatViewController alloc]init];
    //     赋值
#warning mark AVUser
    AVUser * friendUser = self.user;
    NSString *userNameForToken = friendUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *userName = friendUser[@"nickName"];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = userNameForToken;
    chatVC.userName = userName;
    chatVC.title = userName;

    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
