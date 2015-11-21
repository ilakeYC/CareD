//
//  SetPasswordViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/20.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>
{
    BOOL _oldNotEmpty;
    BOOL _newNotEmpty;
}

@property (nonatomic,strong) UIView *mainContentView;
@property (nonatomic,strong) UITextField *oldpassword;
@property (nonatomic,strong) UITextField *newpassword;
@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UIView *secContentView;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"找回密码" style:(UIBarButtonItemStyleDone) target:self action:@selector(findPassword)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.618, 40)];
    self.mainContentView.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, 60);
    self.mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainContentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.mainContentView.layer.shadowOpacity = 0.7;
    self.mainContentView.layer.cornerRadius = 10;
    self.mainContentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mainContentView.layer.masksToBounds = YES;
    self.mainContentView.layer.borderWidth = 1;
    [self.view addSubview:self.mainContentView];
    
    self.oldpassword = [[UITextField alloc] initWithFrame:self.mainContentView.bounds];
    self.oldpassword.borderStyle = UITextBorderStyleNone;
    self.oldpassword.placeholder = @"请输入旧密码";
    self.oldpassword.textAlignment = NSTextAlignmentCenter;
    self.oldpassword.adjustsFontSizeToFitWidth = YES;
    [self.mainContentView addSubview:self.oldpassword];
    
    
    
    
    
    
    
    self.secContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.618, 40)];
    self.secContentView.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, 110);
    self.secContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.secContentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.secContentView.layer.shadowOpacity = 0.7;
    self.secContentView.layer.cornerRadius = 10;
    self.secContentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.secContentView.layer.masksToBounds = YES;
    self.secContentView.layer.borderWidth = 1;
    [self.view addSubview:self.secContentView];
    
    self.newpassword = [[UITextField alloc] initWithFrame:self.secContentView.bounds];
    self.newpassword.borderStyle = UITextBorderStyleNone;
    self.newpassword.placeholder = @"新密码";
    self.newpassword.textAlignment = NSTextAlignmentCenter;
    self.newpassword.adjustsFontSizeToFitWidth = YES;
    [self.secContentView addSubview:self.newpassword];
    
 
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.button.tintColor = [UIColor whiteColor];
    self.button.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.button.layer.cornerRadius = 10;
    self.button.layer.masksToBounds = YES;
    [self.button setTitle:@"设置密码" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.button.frame = CGRectMake(self.secContentView.frame.origin.x, self.secContentView.frame.origin.y + 100, self.secContentView.frame.size.width, 40);
    self.button.enabled = NO;
    [self.view addSubview:self.button];
 
    
    self.oldpassword.delegate = self;
    self.newpassword.delegate = self;
    
    
}

- (void)findPassword {
    FindPassowrdViewController *find = [FindPassowrdViewController new];
    UINavigationController *findNC = [[UINavigationController alloc] initWithRootViewController:find];
    [self presentViewController:findNC animated:YES completion:^{
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.newpassword.text isEqualToString:@""]) {
        _newNotEmpty = NO;
    } else {
        _newNotEmpty = YES;
    }
    
    if ([self.oldpassword.text isEqualToString:@""]) {
        _oldNotEmpty = NO;
    } else {
        _oldNotEmpty = YES;
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.newpassword.text isEqualToString:@""]) {
        _newNotEmpty = NO;
    } else {
        _newNotEmpty = YES;
    }
    
    if ([self.oldpassword.text isEqualToString:@""]) {
        _oldNotEmpty = NO;
    } else {
        _oldNotEmpty = YES;
    }
    
    if (_oldNotEmpty && _newNotEmpty) {
        self.button.enabled = YES;
    } else {
        self.button.enabled = NO;
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.oldpassword isEditing]) {
        [self.newpassword becomeFirstResponder];
    }else {
        [self.view endEditing:YES];
    }
    
    
    return YES;
    
}

- (void)buttonAction {
    
    [[YCUserManager sharedUserManager] resetUserPassword:self.oldpassword.text oldPassword:self.newpassword.text stateBlock:^(BOOL succeed) {
       
        if (succeed) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码修改成功" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"旧密码不正确" message:@"如果您忘记密码，请点击右上角找回密码，我们会为您发送一条邮件来帮助您设置新密码，在这之前，请确定您的邮箱已经被验证。" preferredStyle:(UIAlertControllerStyleAlert)];
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
