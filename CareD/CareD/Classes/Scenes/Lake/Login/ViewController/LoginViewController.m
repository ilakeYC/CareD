//
//  LoginViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LoginView *loginView;

@end

@implementation LoginViewController

- (void)loadView {
    self.loginView = [[LoginView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView.nameTextField.delegate = self;
    self.loginView.passwordTextField.delegate = self;
    
    [self.loginView.registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark - 登陆按钮点击事件
- (void)loginButtonAction:(UIButton *)sender {
    [self.loginView shake];
}
#pragma mark - 注册按钮点击事件
- (void)registerButtonAction:(UIButton *)sender {
    RegisterViewController *registerVC = [RegisterViewController new];
    registerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:registerVC animated:YES completion:^{
        
    }];
}
#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.loginView.nameTextField.isEditing) {
        //是用户名输入框正在响应
        [self.loginView.passwordTextField becomeFirstResponder];
    } else {
        //是密码输入框正在响应
        [self.loginView endEditing:YES];
    }
    return YES;
}
@end
