//
//  HYFriendView.h
//  Demo_Cared
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HYFriendView : UIView

//好友头像、昵称
@property (nonatomic, strong) UIView *shadow_oneView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
//好友所在地
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *cityLabel;
//分割线
@property (nonatomic, strong) UIView *cutView;

//所在地天气
///***内容标题***///
@property (nonatomic, strong) UILabel *tianqiLabel;
@property (nonatomic, strong) UILabel *wenduLanel;
@property (nonatomic, strong) UILabel *kongqiLabel;
@property (nonatomic, strong)  UILabel *juliLabel;
///***内容***///
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UILabel *airLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;
@property (nonatomic, strong) UIView *shadow_twoView;
//发送消息按钮
@property (nonatomic, strong) UIButton *sendMessageButton;


@end
