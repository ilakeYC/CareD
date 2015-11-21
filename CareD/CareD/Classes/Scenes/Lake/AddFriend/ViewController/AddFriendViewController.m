//
//  AddFriendViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendView.h"

@interface AddFriendViewController ()<YCUserFriendRequestManagerDelegate>

@property (nonatomic,strong) AddFriendView *addFriendView;

@end

@implementation AddFriendViewController


- (void)loadView {
    self.addFriendView = [[AddFriendView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.addFriendView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addFriendView.cancelButton];
    [self.addFriendView.cancelButton addTarget:self action:@selector(backToLastVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    #pragma mark - 加载user数据
    [[YCUserImageManager sharedUserImage] getImageUrlWithUser:_user handel:^(NSString *URL) {
        if (!URL) {
            return ;
        }
        [self.addFriendView.imageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:self.image];
        
    }];
    
    NSString *nickName = _user[@"nickName"];
    
    self.addFriendView.userNickNameLabel.text = [NSString stringWithFormat:@"%@还不是您的好友\n如果需要添加好友请点击发送请求",nickName];
    
    
    
    self.navigationItem.titleView = ({
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = _user[@"nickName"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = [UIColor whiteColor];
        label;
        
    });
    
    [self.addFriendView.sendRequestButton addTarget:self action:@selector(addFriendButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setUser:(AVUser *)user {
    NSLog(@"设置user");
    _user = user;
    
}

- (void)addFriendButtonAction {
    NSString *password = self.addFriendView.passwordTextField.text;
    if ([password isEqualToString:@""]) {
        
        self.addFriendView.passwordTipsLabel.text = @"必须有密码";
#warning - 判断没有密码
        
    } else {
        self.addFriendView.passwordTipsLabel.text = @"";
        [[YCUserFriendRequestManager sharedUserFriendRequestManager] sendFriendRequestToUser:_user withPassword:password];
        [YCUserFriendRequestManager sharedUserFriendRequestManager].delegate = self;
        self.addFriendView.sendRequestButton.enabled = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送成功" message:@"请耐心等待对方处理" preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [self backToLastVC];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

- (void)backToLastVC {
    [[NSNotificationCenter defaultCenter] removeObserver:self.addFriendView name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self.addFriendView name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 好友请求发送
- (void)userFriendRequestSendingRequestSuccessedToUser:(AVUser *)user andPassword:(NSString *)password {
    NSLog(@"发送成功");
    self.addFriendView.sendRequestButton.enabled = YES;
    [self backToLastVC];
}
- (void)userFriendRequestSendingRequestFailureToUser:(AVUser *)user andPassword:(NSString *)password {
    self.addFriendView.sendRequestButton.enabled = YES;
    
    
}
@end
