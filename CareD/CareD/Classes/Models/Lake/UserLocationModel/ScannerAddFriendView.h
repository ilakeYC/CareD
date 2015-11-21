//
//  ScannerAddFriendView.h
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScannerAddFriendView : UIView

@property (nonatomic,strong) UIView *userContentShadowView;
@property (nonatomic,strong) UIView *userContentView;

@property (nonatomic,strong) UIView *userImageShadowView;
@property (nonatomic,strong) UIView *userImageContentView;

@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *userNickNameLabel;
@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,strong) UIButton *conformButton;
@end
