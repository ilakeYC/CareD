//
//  AddFriendView.h
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendView : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *imageViewShadowView;
@property (nonatomic,strong) UIView *imageViewMasksView;

@property (nonatomic,strong) UIView *requestLabelShadowView;

@property (nonatomic,strong) UILabel *userNickNameLabel;

@property (nonatomic,strong) UILabel *passwordTipsLabel;
@property (nonatomic,strong) UITextField *passwordTextField;

@property (nonatomic,strong) UIButton *sendRequestButton;
@property (nonatomic,strong) UIButton *cancelButton;

- (void)viewUP;
- (void)viewDown;

@end
