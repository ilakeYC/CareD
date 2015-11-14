//
//  LakeDefines.h
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#ifndef LakeDefines_h
#define LakeDefines_h

/////////////////////////宏定义

//- 尺寸
#define CareD_Lake_MainScreenBounds [UIScreen mainScreen].bounds
#define CareD_Lake_MainScreenBoundsWithoutNavigationBar CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width, CareD_Lake_MainScreenBounds.size.height - 64)

//- 颜色
    ///艾绿
#define CareD_Lake_COLOR_AbsintheGreen [UIColor colorWithRed:136/255.f green:189/255.f blue:65/255.f alpha:1]
    ///警告用红色
#define CareD_Lake_COLOR_WorningRed [UIColor colorWithRed:210/255.f green:15/255.f blue:15/255.f alpha:1]



/////////////////////////头文件

#import <AVOSCloudIM.h>

//- 视图控制器
#import "LoginViewController.h"             //- 登陆_视图控制器
#import "RegisterViewController.h"          //- 注册_视图控制器
#import "RegisterSettingsViewController.h"  //- 注册后的初始化设置_视图控制器
#import "FriendListViewController.h"        //- 好友列表_视图控制器

#import "YCUsers.h"                 //- 用户层

//-第三方或自定义视图
#import "UIShakeView.h"       //- 抖动视图
#import "DeformationButton.h" //- 首页按钮
#import "UIImageView+WebCache.h" //

#endif /* LakeDefines_h */
