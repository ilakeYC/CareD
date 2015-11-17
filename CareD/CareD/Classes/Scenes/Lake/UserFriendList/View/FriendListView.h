//
//  FriendListView.h
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserImageView.h"
#import "YCFriendListView.h"
#import "YCUnreadListView.h"

@interface FriendListView : UIView

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIView *userInfoView;
@property (nonatomic,strong) UIView *userInfoBar;
@property (nonatomic,strong) UIView *userImageBackView;
@property (nonatomic,strong) UIView *userImageMasksView;
@property (nonatomic,strong) UserImageView *userImageView;


@property (nonatomic,strong) UIView *userInfoBarLeftView;
@property (nonatomic,strong) UIView *userInfoBarRightView;

@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *airLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *weatherLabel;


@property (nonatomic,strong) UIView *userInfoBarTopLeftView;
@property (nonatomic,strong) UIView *userInfoBarTopRightView;
@property (nonatomic,strong) YCUnreadListView *unreadListView;

@property (nonatomic,strong) YCFriendListView *theFriendListView;
@end
