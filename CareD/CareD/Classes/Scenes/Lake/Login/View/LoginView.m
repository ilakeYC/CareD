//
//  LoginView.m
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
{
    BOOL _keyboardOnShow;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor grayColor];
    NSLog(@"%@",NSStringFromCGRect(CareD_Lake_MainScreenBounds));
    self.loginImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginImage"]];
    self.loginImageView.frame = CGRectMake(0, 0, 375, 667);
    self.loginImageView.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, CareD_Lake_MainScreenBounds.size.height / 2);
    [self addSubview:self.loginImageView];
    
    
    self.loginNameShakeView = [[UIShakeView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.618, 34)];
    self.loginNameShakeView.center = CGPointMake(self.center.x, self.center.y + 20);
    self.loginNameShakeView.backgroundColor = [UIColor clearColor];
    self.loginNameShakeView.layer.masksToBounds = YES;
    [self addSubview:self.loginNameShakeView];
    
    self.loginPasswordShakeView = [[UIShakeView alloc] initWithFrame:CGRectMake(self.loginNameShakeView.frame.origin.x, self.loginNameShakeView.frame.origin.y + self.loginNameShakeView.frame.size.height * 1.5, self.loginNameShakeView.frame.size.width, self.loginNameShakeView.frame.size.height)];
    self.loginPasswordShakeView.backgroundColor = [UIColor clearColor];
    self.loginPasswordShakeView.layer.masksToBounds = YES;
    [self addSubview:self.loginPasswordShakeView];
    
    
#pragma mark - 用户名输入框
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.loginNameShakeView.bounds.size.width - 40, self.loginNameShakeView.bounds.size.height)];
    self.nameTextField.center = CGPointMake(self.loginNameShakeView.bounds.size.width / 2, self.loginNameShakeView.bounds.size.height / 2);
    self.loginNameShakeView.layer.cornerRadius = self.nameTextField.frame.size.height / 9;
    self.loginNameShakeView.layer.borderWidth = 0.7;
    self.loginNameShakeView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.nameTextField.textColor     = [UIColor darkGrayColor];
    self.nameTextField.placeholder   = @"用户名";
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.nameTextField setKeyboardAppearance:(UIKeyboardAppearanceAlert)];
    [self.nameTextField setKeyboardType:(UIKeyboardTypeNamePhonePad)];
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    
    [self.loginNameShakeView addSubview:({
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)]];
        view.frame = self.loginNameShakeView.bounds;
        view;
    
    })];
    [self.loginNameShakeView addSubview:self.nameTextField];
    
    
    
    
#pragma mark - 密码输入框
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.loginPasswordShakeView.bounds.size.width - 40, self.loginPasswordShakeView.bounds.size.height)];
    self.passwordTextField.center = CGPointMake(self.loginPasswordShakeView.bounds.size.width / 2, self.loginPasswordShakeView.bounds.size.height / 2);
    self.loginPasswordShakeView.layer.cornerRadius = self.loginPasswordShakeView.frame.size.height / 9;
    self.loginPasswordShakeView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginPasswordShakeView.layer.borderWidth = 0.7;
    
    self.passwordTextField.textColor     = [UIColor darkGrayColor];
    self.passwordTextField.placeholder   = @"密码";
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passwordTextField.secureTextEntry = YES;
    
    self.passwordTextField.clearsOnBeginEditing = YES;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    [self.loginPasswordShakeView addSubview:({
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)]];
        view.frame = self.loginNameShakeView.bounds;
        view;
        
    })];
    [self.passwordTextField setKeyboardAppearance:(UIKeyboardAppearanceAlert)];
    [self.passwordTextField setKeyboardType:(UIKeyboardTypeNamePhonePad)];
    [self.loginPasswordShakeView addSubview:self.passwordTextField];
    
    
#pragma mark - 登陆按钮

    self.loginButton = [[DeformationButton alloc] initWithFrame:CGRectMake(CareD_Lake_MainScreenBounds.size.width / 2 - self.loginPasswordShakeView.frame.size.width * 0.618 / 2, self.loginPasswordShakeView.frame.origin.y + self.loginPasswordShakeView.frame.size.height * 2, self.loginPasswordShakeView.frame.size.width * 0.618, self.loginPasswordShakeView.frame.size.height) withColor:CareD_Lake_COLOR_AbsintheGreen];
    
//    self.loginButton.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, self.loginButton.center.y);
    
    [self addSubview:self.loginButton];
    
    self.loginButton.forDisplayButton.backgroundColor = [UIColor clearColor];
    [self.loginButton.forDisplayButton setTitle:@"登陆" forState:(UIControlStateNormal)];
    [self.loginButton.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.loginButton.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    
    self.worningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.loginPasswordShakeView.frame.origin.y + self.loginPasswordShakeView.frame.size.height, CareD_Lake_MainScreenBounds.size.width, 20)];
    self.worningLabel.text = @"用户名或密码错误";
    self.worningLabel.textAlignment = NSTextAlignmentCenter;
    self.worningLabel.textColor = [UIColor redColor];
    self.worningLabel.alpha = 0;
    [self addSubview:self.worningLabel];
//    self.loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    CGFloat loginButtonX = (self.loginNameShakeView.frame.size.width - self.loginNameShakeView.frame.origin.x - self.loginNameShakeView.frame.size.width * 0.618 ) / 2;
    
//    self.loginButton.frame = CGRectMake(0, self.loginPasswordShakeView.frame.origin.y + self.loginPasswordShakeView.frame.size.height * 2, self.loginPasswordShakeView.frame.size.width * 0.618, self.loginPasswordShakeView.frame.size.height);
//    [self.loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
//    [self.loginButton setTitleColor:CareD_Lake_COLOR_AbsintheGreen forState:(UIControlStateNormal)];
//    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height / 2;
//    self.loginButton.layer.borderColor = CareD_Lake_COLOR_AbsintheGreen.CGColor;
//    self.loginButton.layer.borderWidth = 1;
    
#pragma mark - 注册按钮
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.registerButton.frame = CGRectMake(CareD_Lake_MainScreenBounds.size.width - 70, CareD_Lake_MainScreenBounds.size.height - 40, 60, 30);
//    self.registerButton.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, self.registerButton.center.y);
    [self.registerButton setTitle:@"新用户" forState:(UIControlStateNormal)];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.registerButton];
    
#pragma mark - 找回密码按钮
    self.findPasswordButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.findPasswordButton.frame = CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y + self.loginButton.frame.size.height * 2, self.loginButton.frame.size.width, self.loginButton.frame.size.height * 0.3);
    self.findPasswordButton.frame = CGRectMake(10, CareD_Lake_MainScreenBounds.size.height - 40, 100, 30);
    [self.findPasswordButton setTitle:@"忘记密码？" forState:(UIControlStateNormal)];
    [self.findPasswordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.findPasswordButton];
    
    
    
#pragma mark - 键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewUP) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDown) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}


- (void)shake {
    [self.loginNameShakeView shake];
    [self.loginPasswordShakeView shake];
    self.loginPasswordShakeView.backgroundColor = [UIColor redColor];
    self.loginNameShakeView.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:2 animations:^{
        self.loginNameShakeView.backgroundColor = [UIColor clearColor];
        self.loginPasswordShakeView.backgroundColor = [UIColor clearColor];
    }];
}

- (void)checking {
    [self.loginButton setIsLoading:YES];
    self.loginButton.enabled = NO;
}
- (void)unChecking {
    self.loginButton.enabled = YES;
    [self.loginButton setIsLoading:NO];
}

- (void)checkedError {
    self.worningLabel.alpha = 1;
    [UIView animateWithDuration:3 animations:^{
        self.worningLabel.alpha = 0;
    }];
}

#pragma mark - 点击屏幕收回键盘以及视图上下挪动动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)viewUP {
    if (_keyboardOnShow) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y - 100;
        self.frame = frame;
    }];
    _keyboardOnShow = YES;
}
- (void)viewDown {
    if (!_keyboardOnShow) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = 0;
        self.frame = frame;
    }];
    _keyboardOnShow = NO;
}

@end
