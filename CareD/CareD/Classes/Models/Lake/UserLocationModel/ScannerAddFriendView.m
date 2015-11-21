//
//  ScannerAddFriendView.m
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "ScannerAddFriendView.h"

@implementation ScannerAddFriendView

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
    self.frame = CareD_Lake_MainScreenBoundsWithoutNavigationBar;
    
    self.userContentShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.8, CareD_Lake_MainScreenBounds.size.height * 0.618)];
    self.userContentShadowView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.userContentShadowView.backgroundColor = [UIColor whiteColor];
    self.userContentShadowView.layer.cornerRadius = 10;
    self.userContentShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.userContentShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.userContentShadowView.layer.shadowOpacity = 0.7;
    [self addSubview:self.userContentShadowView];
    
    
    self.userContentView = [[UIView alloc] initWithFrame:self.userContentShadowView.bounds];
    self.userContentView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.userContentView.layer.cornerRadius = 10;
//    self.userContentView.backgroundColor = [UIColor whiteColor];
    [self.userContentShadowView addSubview:self.userContentView];
    
    self.userImageShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userContentView.frame.size.width / 2, self.userContentView.frame.size.width / 2)];
    
    self.userImageShadowView.layer.cornerRadius = self.userImageShadowView.frame.size.height / 2;
    self.userImageShadowView.layer.shadowOpacity = 0.7;
    self.userImageShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.userImageShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.userImageShadowView.backgroundColor = [UIColor whiteColor];
    self.userImageShadowView.center = CGPointMake(self.userContentView.frame.size.width / 2, self.userImageShadowView.frame.size.height / 2 + 10);
    [self.userContentView addSubview:self.userImageShadowView];
    
    self.userImageContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.userImageShadowView.frame.size.width - 20, self.userImageShadowView.frame.size.height - 20)];
    self.userImageContentView.layer.cornerRadius = self.userImageContentView.frame.size.height / 2;
    self.userImageContentView.layer.masksToBounds = YES;
    [self.userImageShadowView addSubview:self.userImageContentView
     ];
    
    self.userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-512"]];
    self.userImageView.frame = self.userImageContentView.bounds;
    [self.userImageContentView addSubview:self.userImageView];
    
    
    self.userNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userImageShadowView.frame.size.height + self.userImageShadowView.frame.origin.y, self.userContentView.frame.size.width, 30)];
    self.userNickNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNickNameLabel.textColor = [UIColor whiteColor];
    self.userNickNameLabel.font = [UIFont systemFontOfSize:22];
    [self.userContentView addSubview:self.userNickNameLabel];
    
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userNickNameLabel.frame.origin.y + self.userNickNameLabel.frame.size.height + 8, self.userNickNameLabel.frame.size.width, 40)];
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    self.tipsLabel.textColor = [UIColor whiteColor];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.text = @"是否添加他为好友？";
    [self.userContentView addSubview:self.tipsLabel];
    
    
    self.conformButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.conformButton.frame = CGRectMake((self.userContentView.frame.size.width - self.userContentView.frame.size.width * 0.382) / 2, self.userContentView.frame.size.height - 60, self.userContentView.frame.size.width * 0.382, 50);
    self.conformButton.layer.cornerRadius = 10;
    self.conformButton.layer.masksToBounds = YES;
    self.conformButton.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.conformButton.layer.borderWidth = 1;
    self.conformButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.conformButton setTintColor:[UIColor whiteColor]];
    [self.conformButton setTitle:@"添加好友" forState:(UIControlStateNormal)];
    [self.userContentView addSubview:self.conformButton];
    
}

@end
