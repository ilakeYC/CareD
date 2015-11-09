//
//  LoginView.h
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic,strong) UIImageView *loginImageView;
@property (nonatomic,strong) UIShakeView *loginNameShakeView;
@property (nonatomic,strong) UIShakeView *loginPasswordShakeView;

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) UIButton *findPasswordButton;

- (void)shake;

///视图上移
- (void)viewUP;
///视图下移
- (void)viewDown;
@end
