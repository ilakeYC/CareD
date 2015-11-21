//
//  ScannerAddFriendController.m
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "ScannerAddFriendController.h"
#import "ScannerAddFriendView.h"

@interface ScannerAddFriendController ()

@property (nonatomic,strong) ScannerAddFriendView *scannerAddFriendView;

@end

@implementation ScannerAddFriendController

- (void)loadView {
    self.scannerAddFriendView = [[ScannerAddFriendView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.scannerAddFriendView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(backToLastVC)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.scannerAddFriendView.conformButton addTarget:self action:@selector(addFriendRequest) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (!_user) {
        self.scannerAddFriendView.userContentShadowView.hidden = YES;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有找到二维码对应的用户" message:@"请扫描CareD生成的二维码来添加好友哦" preferredStyle:(UIAlertControllerStyleAlert)];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            [self backToLastVC];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
    } else {
        self.scannerAddFriendView.userContentShadowView.hidden = NO;
        self.scannerAddFriendView.userNickNameLabel.text = _user[@"nickName"];
        self.scannerAddFriendView.tipsLabel.text = @"是否添加他为好友";
        [[YCUserImageManager sharedUserImage] getImageWithUser:_user handel:^(UIImage *image) {
            self.scannerAddFriendView.userImageView.image = image;
        }];
        
    }
}

- (void)setUser:(AVUser *)user {
    NSLog(@"%@",user.username);
    _user = user;

}

- (void)addFriendRequest {
    AddFriendViewController *addFriendVC = [AddFriendViewController new];
    addFriendVC.user = self.user;
    [self.navigationController pushViewController:addFriendVC animated:YES];
}

- (void)backToLastVC {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
