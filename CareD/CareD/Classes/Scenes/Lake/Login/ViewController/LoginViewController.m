//
//  LoginViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<UITextFieldDelegate,YCUserManagerDelegate>
@property (nonatomic,strong) LoginView *loginView;
@property (nonatomic,strong) YCUserManager *userManager;

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
    
    self.userManager = [YCUserManager sharedUserManager];
    [self.userManager addDelegate:self];
    
    [self.loginView.findPasswordButton addTarget:self action:@selector(findPasswordButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.loginView.registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#warning remember to open this for login use current user
    [self.userManager logInWithCurrentUserAndReturnToken];
}

- (void)findPasswordButtonAction {
    FindPassowrdViewController *find = [FindPassowrdViewController new];
    UINavigationController *findNC = [[UINavigationController alloc] initWithRootViewController:find];
    [self presentViewController:findNC animated:YES completion:^{
        
    }];
}

#pragma mark - 登陆按钮点击事件
- (void)loginButtonAction:(UIButton *)sender {
    [self.loginView endEditing:YES];
    [self.loginView checking];
    [self performSelector:@selector(loginButtonActionAfter) withObject:self afterDelay:2];

}
- (void)loginButtonActionAfter {
    [self.userManager logInReturnTokenWithUserName:self.loginView.nameTextField.text password:self.loginView.passwordTextField.text];
}
#pragma mark - 注册按钮点击事件
- (void)registerButtonAction:(UIButton *)sender {
    [self.loginView endEditing:YES];
    RegisterViewController *registerVC = [RegisterViewController new];
    registerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
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

#pragma mark - UserManagerDelegates
//用户名密码登陆成功返回token
- (void)userManagerLogInLoginWithUserNameAndPasswordSuccessed:(AVUser *)user token:(NSString *)token {
    NSLog(@"登陆成功.%@",token);
    // 登陆融云
    [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
        NSLog(@"融云登陆成功1 = %@",token);
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"登陆融云失败");
    } tokenIncorrect:^{
        NSLog(@"token 失效");
    }];
    [self.loginView unChecking];
    
    [[YCUserImageManager sharedUserImage] getCurrentUserImage];
    [self presentFriendListViewController];
}
//登陆失败
- (void)userManagerLogInLoginWithUserNameAndPasswordFaliure {
    NSLog(@"登陆失败");
    [self.loginView shake];
    [self.loginView unChecking];
    [self.loginView checkedError];
}
//将要使用当前用户登陆
- (void)userManagerLogInWillLoginWithCurrentUser {
    [self.loginView.loginButton setIsLoading:YES];
    [self.loginView checking];
}
//当前用户登陆成功
- (void)userManagerLogInLoginWithCurrentUserSccessed:(AVUser *)currentUser token:(NSString *)token {
    [self.loginView unChecking];
    NSLog(@"%@",token);
    NSLog(@"用户登陆成功");
    
#warning mark 重新连接(原因进入后台掉线？？)
    [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
        NSLog(@"融云登陆成功1 = %@",token);
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"登陆融云失败");
    } tokenIncorrect:^{
        NSLog(@"token 失效");
    }];
    
    [self presentFriendListViewController];
}
//
- (void)userManagerLogInLoginWithCurrentUserFaliure {
    [self.loginView unChecking];
}

- (void)presentFriendListViewController {
    FriendListViewController *friendListVC = [FriendListViewController new];
    UINavigationController *friendListNC = [[UINavigationController alloc] initWithRootViewController:friendListVC];
    
    friendListNC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:friendListNC animated:YES completion:^{
        NSLog(@"登陆后");
    }];
}
- (void)dealloc {
    NSLog(@"登陆后");
}
@end
