//
//  FriendListView.m
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendListView.h"

@implementation FriendListView

static NSInteger const userInfoBarHight = 49;



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [[UIView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar];
    [self addSubview:self.contentView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.7;
    [self.contentView addSubview:view];
    
    [self makeUserInfoBar];
    [self makeUserImageView];
    [self makeLabels];
    [self makeTheFriendListView];
    [self makeUnreadListView];
}
//绘制用户详情栏背景
- (void)makeUserInfoBar {
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - userInfoBarHight * 2, CareD_Lake_MainScreenBounds.size.width, userInfoBarHight * 2)];
    [self.contentView addSubview:userInfoView];
    self.userInfoView = userInfoView;
    
    
    UIView *userImageBackViewForShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, userInfoBarHight * 2, userInfoBarHight * 2)];
    userImageBackViewForShadow.center = CGPointMake(userInfoView.frame.size.width / 2, userInfoView.frame.size.height / 2);
    userImageBackViewForShadow.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    userImageBackViewForShadow.layer.shadowOffset = CGSizeMake(0, -1);
    userImageBackViewForShadow.layer.shadowOpacity = 0.7;
    userImageBackViewForShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    userImageBackViewForShadow.layer.cornerRadius = userInfoBarHight;
    [userInfoView addSubview:userImageBackViewForShadow];
    
    UIView *userInfoBarForShadow = [[UIView alloc] initWithFrame:CGRectMake(0, userInfoBarHight, CareD_Lake_MainScreenBounds.size.width, userInfoBarHight)];
    userInfoBarForShadow.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    userInfoBarForShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    userInfoBarForShadow.layer.shadowOffset = CGSizeMake(0, -1);
    userInfoBarForShadow.layer.shadowOpacity = 0.7;
    [userInfoView addSubview:userInfoBarForShadow];
    
    
    self.userInfoBar = [[UIView alloc] initWithFrame:userInfoBarForShadow.bounds];
    self.userInfoBar.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [userInfoBarForShadow addSubview:self.userInfoBar];
    
    UIView *userImageMainBackView = [[UIView alloc] initWithFrame:userImageBackViewForShadow.bounds];
    userImageMainBackView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    userImageMainBackView.layer.cornerRadius = userInfoBarHight;
    userImageMainBackView.layer.masksToBounds = YES;
    userImageMainBackView.center = userImageBackViewForShadow.center;
    
    [userInfoView addSubview:userImageMainBackView];
    
    self.userImageBackView = [[UIView alloc] initWithFrame:CGRectMake(6, 6, userImageMainBackView.frame.size.width - 12, userImageMainBackView.frame.size.height - 12)];
    self.userImageBackView.backgroundColor = [UIColor whiteColor];
    self.userImageBackView.layer.cornerRadius = self.userImageBackView.frame.size.height / 2;
    self.userImageBackView.layer.masksToBounds = YES;
    [userImageMainBackView addSubview:self.userImageBackView];
    
    self.userImageMasksView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.userImageBackView.frame.size.width - 10, self.userImageBackView.frame.size.height - 10)];
    self.userImageMasksView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.userImageMasksView.layer.cornerRadius = self.userImageMasksView.frame.size.height / 2;
    self.userImageMasksView.layer.masksToBounds = YES;
    [self.userImageBackView addSubview:self.userImageMasksView];
}
//添加用户图片
- (void)makeUserImageView {
    self.userImageView = [[UserImageView alloc] initWithFrame:self.userImageMasksView.bounds];
    [self.userImageMasksView addSubview:self.userImageView];
    
    [self.userImageView setImage:[UIImage imageNamed:@"Icon-512"]];
}
//添加label
- (void)makeLabels {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M月d日 EEEE"];
    [dateFormatter setTimeZone:GTMzone];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    self.userInfoBarLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width / 2 - userInfoBarHight, userInfoBarHight)];
    [self.userInfoBar addSubview:self.userInfoBarLeftView];
    
    self.userInfoBarRightView = [[UIView alloc] initWithFrame:CGRectMake(self.userInfoBarLeftView.frame.size.width + userInfoBarHight * 2, self.userInfoBarLeftView.frame.origin.y, self.userInfoBarLeftView.frame.size.width, self.userInfoBarLeftView.frame.size.height)];
    [self.userInfoBar addSubview:self.userInfoBarRightView];
    
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.userInfoBarRightView.frame.size.width, self.userInfoBarRightView.frame.size.height / 2)];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.text = dateString;
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    [self.userInfoBarRightView addSubview:self.dateLabel];
    
    self.airLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.dateLabel.frame.size.height, self.dateLabel.frame.size.width, self.dateLabel.frame.size.height)];
    self.airLabel.textColor = [UIColor whiteColor];
    self.airLabel.textAlignment = NSTextAlignmentCenter;
    self.airLabel.text = @"空气质量:良";
    self.airLabel.adjustsFontSizeToFitWidth = YES;
    [self.userInfoBarRightView addSubview:self.airLabel];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:self.dateLabel.bounds];
    self.locationLabel.textColor = [UIColor whiteColor];
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.locationLabel.text = @"北京市，海淀区";
    self.locationLabel.adjustsFontSizeToFitWidth = YES;
    [self.userInfoBarLeftView addSubview:self.locationLabel];
    
    self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationLabel.frame.origin.x, self.locationLabel.frame.size.height, self.locationLabel.frame.size.width, self.locationLabel.frame.size.height)];
    self.weatherLabel.textColor = [UIColor whiteColor];
    self.weatherLabel.textAlignment = NSTextAlignmentCenter;
    self.weatherLabel.text = @"3℃/小雪";
    self.weatherLabel.adjustsFontSizeToFitWidth = YES;
    [self.userInfoBarLeftView addSubview:self.weatherLabel];
    
}
//添加friendList
- (void)makeTheFriendListView {
    self.theFriendListView = [[YCFriendListView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width, self.contentView.frame.size.height - userInfoBarHight)];
    [self.contentView addSubview:self.theFriendListView];
    [self.contentView sendSubviewToBack:self.theFriendListView];
    
}

- (void)makeUnreadListView {
    self.userInfoBarTopLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userInfoBarLeftView.frame.size.width, self.userInfoBarLeftView.frame.size.height)];
    [self.userInfoView addSubview:self.userInfoBarTopLeftView];
    
    self.userInfoBarTopRightView = [[UIView alloc] initWithFrame:CGRectMake(self.userInfoBarRightView.frame.origin.x, 0, self.userInfoBarRightView.frame.size.width, self.userInfoBarRightView.frame.size.height)];
    [self.userInfoView addSubview:self.userInfoBarTopRightView];
    
    self.unreadListView = [[YCUnreadListView alloc] initWithFrame:self.userInfoBarTopLeftView.bounds];
    [self.userInfoBarTopLeftView addSubview:self.unreadListView];
    
}


@end
