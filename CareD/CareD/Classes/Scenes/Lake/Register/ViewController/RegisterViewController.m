//
//  RegisterViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/12.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<YCUserManagerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *worningLabel;

@property (weak, nonatomic) IBOutlet UIView *userNameBackView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIView *userNameLineView;


@property (weak, nonatomic) IBOutlet UIView *passwordBackView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIView *emailBackView;
@property (weak, nonatomic) IBOutlet UITextField *emainTextField;
@property (weak, nonatomic) IBOutlet UIView *emailLineView;


@property (weak, nonatomic) IBOutlet UIView *signUpButtonBackView;
@property (nonatomic,strong) DeformationButton *signUpButton;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic,strong) YCUserManager *userManager;

@property (nonatomic,strong) UIAlertController *alertController;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signUpButtonBackView.backgroundColor = [UIColor clearColor];
    self.worningLabel.alpha = 0;
    self.worningLabel.textColor = CareD_Lake_COLOR_WorningRed;
    
    
    [self.backButton addTarget:self action:@selector(dismissVC) forControlEvents:(UIControlEventTouchUpInside)];

    
    
    //添加键盘状态通知,用来移动视图位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown) name:UIKeyboardWillHideNotification object:nil];
    self.userManager = [YCUserManager sharedUserManager];
    [self.userManager addDelegate:self];
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.emainTextField.delegate = self;
    
    self.alertController = [UIAlertController alertControllerWithTitle:@"注册成功!" message:@"欢迎来到CareD！\n我们已经为你发送了验证邮件，请注意激活邮箱。\n您也可以稍后在设置页面进行邮箱激活和修改。\n现在只需要一些设置就可以开始使用啦!" preferredStyle:(UIAlertControllerStyleActionSheet)];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"开始设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击");
        RegisterSettingsViewController *registerSettingsVC = [RegisterSettingsViewController new];
        UINavigationController *registerSettingsNC = [[UINavigationController alloc] initWithRootViewController:registerSettingsVC];
        
        registerSettingsNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:registerSettingsNC animated:YES completion:^{
            self.view = nil;
            
        }];
    }]];
}
- (void)viewDidAppear:(BOOL)animated {
    CGRect buttonFrame = CGRectMake((CareD_Lake_MainScreenBounds.size.width - CareD_Lake_MainScreenBounds.size.width * 0.382) / 2, self.signUpButtonBackView.frame.origin.y, CareD_Lake_MainScreenBounds.size.width * 0.382, 38);
    
    self.signUpButton = [[DeformationButton alloc] initWithFrame:buttonFrame withColor:[UIColor orangeColor]];
    [self.view addSubview:self.signUpButton];
    [self.signUpButton.forDisplayButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.signUpButton.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.signUpButton.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUpButton.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [self.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [super viewDidAppear:animated];
    
#warning - remember to remove this test line
//    [self showViewController:self.alertController sender:self];
}

//返回上一控制器
- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)showWorningLabel {
    self.worningLabel.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2];
    [UIView setAnimationDuration:3];
    self.worningLabel.alpha = 0;
    [UIView commitAnimations];
}

//用户名错误警告
- (void)userNameWrong {
    self.userNameLineView.backgroundColor = CareD_Lake_COLOR_WorningRed;
    self.worningLabel.text = @"用户名被占用";
    [self showWorningLabel];
}
//取消用户名错误警告
- (void)cancelUserNameWrong {
    [UIView animateWithDuration:1 animations:^{
        self.userNameLineView.backgroundColor = [UIColor whiteColor];
    }];
}
//邮箱错误
- (void)userEmailWrong {
    self.emailLineView.backgroundColor = CareD_Lake_COLOR_WorningRed;
    self.worningLabel.text = @"邮箱被占用";
    [self showWorningLabel];
}
- (void)userEmailWasInvalid {
    self.emailLineView.backgroundColor = CareD_Lake_COLOR_WorningRed;
    self.worningLabel.text = @"邮箱格式不正确";
    [self showWorningLabel];
}
//邮箱正确
- (void)cancelUserEmailWrong {
    [UIView animateWithDuration:1 animations:^{
        self.emailLineView.backgroundColor = [UIColor whiteColor];
    }];
}

//点击屏幕结束编辑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//键盘出现
- (void)keyboardUp {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -50;
        self.view.frame = frame;
    }];
}

//键盘消失
- (void)keyboardDown {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

- (void)checking {
    self.signUpButton.enabled = NO;
}
- (void)unChecking {
    self.signUpButton.enabled = YES;
    [self.signUpButton setIsLoading:NO];
}
///注册按钮点击
- (void)signUpButtonAction:(DeformationButton *)sender {
    [self checking];
    [self performSelector:@selector(signUpButtonActionAfter) withObject:self afterDelay:1.5f];
}

- (void)signUpButtonActionAfter {
    NSString *email         = self.emainTextField.text;
    NSString *userName      = self.userNameTextField.text;
    NSString *userPassword  = self.passwordTextField.text;
    [self.userManager registerUserAndGetToken:userName password:userPassword email:email];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        [self cancelUserNameWrong];
    }
    if (textField == self.emainTextField) {
        [self cancelUserEmailWrong];
    }
    return YES;
}

#pragma mark - textField Delegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.emainTextField becomeFirstResponder];
    } else if (textField == self.emainTextField) {
        [self.emainTextField resignFirstResponder];
    }
    return YES;
}


#pragma mark - userManager Delegates
//将要注册
- (void)userManagerRegisterWillRegister {
    NSLog(@"准备注册");
}
//注册失败
- (void)userManagerRegisterUserFailure:(YCUserManagerRegisterError)error {
    if (error == YCUserManagerRegisterErrorHasSameUserName) {
        [self userNameWrong];
    }
    if (error == YCUserManagerRegisterErrorHasSameEmail) {
        [self userEmailWrong];
    }
    if (error == YCUserManagerRegisterErrorNetworkingFailure) {
        
    }
    if (error == YCUserManagerRegisterErrorUserEmailIsNotvalid) {
        [self userEmailWasInvalid];
    }
    [self unChecking];
}
//注册成功
- (void)userManagerRegisterUserSuccessed:(AVUser *)user token:(NSString *)token {
    NSLog(@"注册成功%@",token);
    [self unChecking];
    
// 登陆融云
    [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
        NSLog(@"融云登陆成功1 = %@",token);
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"登陆融云失败");
    } tokenIncorrect:^{
        NSLog(@"token 失效");
    }];
    
    
    [self showViewController:self.alertController sender:self];
}

@end
