//
//  HYFriendView.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYFriendView.h"
#define CareD_Lake_COLOR_AbsintheGreen [UIColor colorWithRed:136/255.f green:189/255.f blue:65/255.f alpha:1]

#define YHY_BackgroundColor [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1]

#define kMainScreen [UIScreen mainScreen].bounds
#define kFSWidth frame.size.width
#define kFSHeight frame.size.height
#define kFOriginX frame.origin.x
#define kFOriginY frame.origin.y

@interface HYFriendView ()

@end


@implementation HYFriendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.
    //好友信息(第一部分)
    self.shadow_oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen.size.width, 100)];
    self.shadow_oneView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.shadow_oneView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadow_oneView.layer.shadowOffset = CGSizeMake(0, 1);
    self.shadow_oneView.layer.shadowOpacity = 0.6;
    [self addSubview:self.shadow_oneView];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
    self.headView.backgroundColor = [UIColor yellowColor];
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.cornerRadius = self.headView.kFSWidth / 2;
    [self addSubview:self.headView];
    
    self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-512"]];
    self.headImageView.frame = CGRectMake(0, 0, self.headView.kFSWidth, self.headView.kFSHeight);
    [self.headView addSubview:self.headImageView];
    
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.kFOriginX + self.headView.kFSWidth + 20, self.headView.kFOriginY + self.headImageView.frame.origin.y + self.headImageView.frame.size.height / 2 - 15, CareD_Lake_MainScreenBounds.size.width - self.headView.kFOriginX + self.headView.kFSWidth + 20 - 40, 30)];
    self.nicknameLabel.text = @"在乎，你在乎的人。";
    self.nicknameLabel.textColor = [UIColor whiteColor];
    self.nicknameLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:self.nicknameLabel];

    //好友信息(第二部分)
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 40, 40)];
    //self.locationLabel.backgroundColor = [UIColor yellowColor];
    self.locationLabel.text = @"地区";
    [self addSubview:self.locationLabel];
    
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationLabel.kFOriginX + self.locationLabel.kFSWidth + 10,self.locationLabel.kFOriginY, kMainScreen.size.width - 20, 40)];
    self.cityLabel.text = @"正在获取对方位置";
    self.cityLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.cityLabel];
    
    self.cutView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kMainScreen.size.width, 1)];
    self.cutView.backgroundColor = YHY_BackgroundColor;
    [self addSubview:self.cutView];
    
    self.tianqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 40, 30)];
    self.tianqiLabel.text = @"天气:";
    [self addSubview:self.tianqiLabel];
    
    self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tianqiLabel.kFOriginX + self.tianqiLabel.kFSWidth + 10, self.tianqiLabel.kFOriginY, 120, self.tianqiLabel.kFSHeight)];
    //self.weatherLabel.backgroundColor = [UIColor yellowColor];
    self.weatherLabel.font = [UIFont systemFontOfSize:15];
    self.weatherLabel.text = @"暂时不支持该城市";
    [self addSubview:self.weatherLabel];
    
    self.wenduLanel = [[UILabel alloc] initWithFrame:CGRectMake(self.tianqiLabel.kFOriginX, self.tianqiLabel.kFOriginY + 30, self.tianqiLabel.kFSWidth, self.tianqiLabel.kFSHeight)];
    self.wenduLanel.text = @"温度:";
    [self addSubview:self.wenduLanel];
    
    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.wenduLanel.kFOriginX + self.wenduLanel.kFSWidth + 10, self.wenduLanel.kFOriginY, 120, self.wenduLanel.kFSHeight)];
   // self.tempLabel.backgroundColor = [UIColor yellowColor];
    self.tempLabel.font = [UIFont systemFontOfSize:15];
    self.tempLabel.text = @"暂时不支持该城市";
    [self addSubview:self.tempLabel];
    
    
    self.kongqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.wenduLanel.kFOriginX, self.wenduLanel.kFOriginY + 30, self.wenduLanel.kFSWidth + 40 , self.wenduLanel.kFSHeight)];
    self.kongqiLabel.text = @"空气质量:";
    [self addSubview:self.kongqiLabel];
    
    self.airLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.kongqiLabel.kFOriginX + self.kongqiLabel.kFSWidth + 10, self.kongqiLabel.kFOriginY, 120, self.kongqiLabel.kFSHeight)];
    //self.airLabel.backgroundColor = [UIColor yellowColor];
    self.airLabel.font = [UIFont systemFontOfSize:15];
    self.airLabel.text = @"暂时不支持该城市";
    [self addSubview:self.airLabel];

    
    self.juliLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.kongqiLabel.kFOriginX, self.kongqiLabel.kFOriginY + 30, self.kongqiLabel.kFSWidth - 40 , self.kongqiLabel.kFSHeight)];
    self.juliLabel.text = @"相距:";
    [self addSubview:self.juliLabel];
    
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.juliLabel.kFOriginX + self.juliLabel.kFSWidth + 10, self.juliLabel.kFOriginY, 200, self.juliLabel.kFSHeight)];
   // self.distanceLabel.backgroundColor = [UIColor yellowColor];
    self.distanceLabel.font = [UIFont systemFontOfSize:15];
    self.distanceLabel.text = @"正在计算距离";
    [self addSubview:self.distanceLabel];
    
    
    self.weatherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Fog"]];
    self.weatherImageView.frame = CGRectMake(kMainScreen.size.width - 120, self.cutView.kFOriginY + 20, 100, 100);
    [self addSubview:self.weatherImageView];
    
    self.shadow_twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, kMainScreen.size.width, 20)];
    self.shadow_twoView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.shadow_twoView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadow_twoView.layer.shadowOffset = CGSizeMake(0, -1);
    self.shadow_twoView.layer.shadowOpacity = 0.6;
    [self addSubview:self.shadow_twoView];
    
    
    //聊天按钮
    self.sendMessageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.sendMessageButton.frame = CGRectMake(100, 340, kMainScreen.size.width - 200, 40);
    [self.sendMessageButton setTitle:@"发消息" forState:(UIControlStateNormal)];
    [self.sendMessageButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.sendMessageButton setBackgroundColor:CareD_Lake_COLOR_AbsintheGreen];
    self.sendMessageButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.sendMessageButton.layer.shadowOffset = CGSizeMake(0, -1);
    self.sendMessageButton.layer.shadowOpacity = 0.6;
    self.sendMessageButton.layer.cornerRadius = 10;
    [self addSubview:self.sendMessageButton];
    
}

@end
