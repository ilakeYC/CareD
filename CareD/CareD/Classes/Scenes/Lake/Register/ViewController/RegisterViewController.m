//
//  RegisterViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController ()
@property (nonatomic,strong) RegisterView *registerView;
@end

@implementation RegisterViewController

- (void)loadView {
    self.registerView = [[RegisterView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.registerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //临时按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backButton.frame = CGRectMake(0, 0, 100, 100);
    backButton.center = self.registerView.center;
    [backButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.registerView addSubview:backButton];
}
- (void)backVC {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
