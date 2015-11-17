//
//  FriendRequestViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/17.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendRequestViewController.h"
#import "FriendRequestView.h"

@interface FriendRequestViewController ()
{
    NSInteger _count;
}

@property (nonatomic,strong) FriendRequestView *friendRequestView;

@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation FriendRequestViewController

- (void)loadView {
    self.friendRequestView = [[FriendRequestView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.friendRequestView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.friendRequestView.cancelButton];
    [self.friendRequestView.cancelButton addTarget:self action:@selector(backToLastVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.titleView = ({
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = _user[@"nickName"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = [UIColor whiteColor];
        label;
        
    });
    
    self.friendRequestView.userNickNameLabel.text = [NSString stringWithFormat:@"%@请求添加您为好友",_user[@"nickName"]];
    
    [self.friendRequestView.sendRequestButton addTarget:self action:@selector(sendRequest:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)setUser:(AVUser *)user {
    _user = user;
}

- (void)sendRequest:(UIButton *)sender {
    
    NSString *userPassword = self.friendRequestView.passwordTextField.text;
    if ([userPassword isEqualToString:@""]) {
        
    }else {
        
        if ([userPassword isEqualToString:_password]) {
            
            self.friendRequestView.passwordTipsLabel.text = @"";
            
            [[YCUserFriendRequestManager sharedUserFriendRequestManager] feedBackYESToUser:_user];
            
            
            self.alertController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"等待对方应答" preferredStyle:(UIAlertControllerStyleAlert)];
            [self.alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self showViewController:self.alertController sender:nil];
            
        } else {
            
            self.friendRequestView.passwordTipsLabel.text = [NSString stringWithFormat:@"密码不匹配，您还可以尝试%ld次",3-_count];
            
            if (_count >= 3) {
                [[YCUserFriendRequestManager sharedUserFriendRequestManager] feedBackNOToUser:_user];
                
                self.alertController = [UIAlertController alertControllerWithTitle:@"添加好友失败" message:@"您尝试密码次数过多，我们做为拒绝处理请求" preferredStyle:(UIAlertControllerStyleAlert)];
                [self.alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }]];
                [self showViewController:self.alertController sender:nil];
                _count ++;
                
            } else {
                
                _count ++;
                
            }
        }
        
        
    }
    
    
}

- (void)backToLastVC {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
