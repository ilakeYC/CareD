//
//  FriendRequestView.m
//  CareD
//
//  Created by LakesMac on 15/11/17.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendRequestView.h"


@interface FriendRequestView ()
{
    BOOL _keyboardUP;
}
@end

@implementation FriendRequestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.7;
    [self addSubview:view];
    
    self.imageViewShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, CareD_Lake_MainScreenBounds.size.width, CareD_Lake_MainScreenBoundsWithoutNavigationBar.size.height - 12)];
    self.imageViewShadowView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.imageViewShadowView.layer.cornerRadius = 20;
    self.imageViewShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageViewShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.imageViewShadowView.layer.shadowOpacity = 0.7;
    [self addSubview:self.imageViewShadowView];
    
    self.imageViewMasksView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imageViewShadowView.frame.size.width, self.imageViewShadowView.frame.size.width)];
    self.imageViewMasksView.layer.cornerRadius = 20;
    self.imageViewMasksView.layer.masksToBounds = YES;
    [self.imageViewShadowView addSubview:self.imageViewMasksView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.imageViewMasksView.bounds];
    self.imageView.image = [UIImage imageNamed:@"Icon-512"];
    [self.imageViewMasksView addSubview:self.imageView];
    
    
    
    
    self.requestLabelShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageViewMasksView.frame.size.height - 30, self.bounds.size.width, self.imageViewShadowView.frame.size.height - self.imageViewMasksView.frame.size.height + 30)];
    
    self.requestLabelShadowView.backgroundColor = [UIColor whiteColor];
    self.requestLabelShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.requestLabelShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.requestLabelShadowView.layer.shadowOpacity = 0.7;
    
    [self.imageViewShadowView addSubview:self.requestLabelShadowView];
    
    
    [self makeLabels];
    [self addKeyBoardNotifaction];
    [self makeButtons];
    
}
- (void)makeLabels {
    self.userNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, self.requestLabelShadowView.frame.size.width - 40, 60)];
    self.userNickNameLabel.textColor = [UIColor darkGrayColor];
    self.userNickNameLabel.text = @"正在加载数据";
    self.userNickNameLabel.numberOfLines = 0;
    self.userNickNameLabel.font = [UIFont systemFontOfSize:14];
    self.userNickNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.requestLabelShadowView addSubview:self.userNickNameLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.userNickNameLabel.frame.origin.x + 15, self.userNickNameLabel.frame.origin.y + self.userNickNameLabel.frame.size.height + 8, self.userNickNameLabel.frame.size.width - 30, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.requestLabelShadowView addSubview:line];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.requestLabelShadowView.frame.size.width * 0.382 / 2, line.frame.origin.y + 10, self.requestLabelShadowView.frame.size.width * 0.618, 30)];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.placeholder = @"请输入请求密码,不能为空";
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    [self.requestLabelShadowView addSubview:self.passwordTextField];
    self.passwordTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.passwordTextField.frame.origin.x, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 5, self.passwordTextField.frame.size.width, 60)];
    self.passwordTipsLabel.textColor = [UIColor grayColor];
    self.passwordTipsLabel.text = @"请与您的好友现实中取得联系，得到密码";
    self.passwordTipsLabel.numberOfLines = 0;
    self.passwordTipsLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordTipsLabel.adjustsFontSizeToFitWidth = YES;
    [self.requestLabelShadowView addSubview:self.passwordTipsLabel];
    
}

- (void)makeButtons {
    self.sendRequestButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.sendRequestButton.frame = CGRectMake(0, self.requestLabelShadowView.frame.size.height - 38, self.passwordTextField.frame.size.width * 0.618, 30);
    self.sendRequestButton.center = CGPointMake(self.requestLabelShadowView.frame.size.width / 2, self.sendRequestButton.center.y);
    self.sendRequestButton.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [self.sendRequestButton setTintColor:[UIColor whiteColor]];
    [self.sendRequestButton setTitle:@"验证" forState:(UIControlStateNormal)];
    self.sendRequestButton.layer.borderColor = CareD_Lake_COLOR_AbsintheGreen.CGColor;
    self.sendRequestButton.layer.borderWidth = 1;
    self.sendRequestButton.layer.cornerRadius = 5;
    self.sendRequestButton.layer.masksToBounds = YES;
    [self.requestLabelShadowView addSubview:self.sendRequestButton];
    
    
    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.cancelButton setImage:[UIImage imageNamed:@"backButton"] forState:(UIControlStateNormal)];
    [self.cancelButton setTintColor:[UIColor whiteColor]];
    self.cancelButton.frame = CGRectMake(0, 0, 30, 30);
    
}



- (void)addKeyBoardNotifaction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewUP) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDown) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewUP {
    if (_keyboardUP) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.requestLabelShadowView.frame;
        frame.origin.y = (self.imageViewMasksView.frame.size.height - 30 ) / 2;
        self.requestLabelShadowView.frame = frame;
        
    }];
    
    _keyboardUP = YES;
}
- (void)viewDown {
    if (!_keyboardUP) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.requestLabelShadowView.frame;
        frame.origin.y = self.imageViewMasksView.frame.size.height - 30;
        self.requestLabelShadowView.frame = frame;
        
    }];
    _keyboardUP = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


@end
