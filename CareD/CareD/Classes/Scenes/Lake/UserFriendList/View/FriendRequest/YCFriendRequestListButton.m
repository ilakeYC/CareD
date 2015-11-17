//
//  YCFriendRequestListButton.m
//  CareD
//
//  Created by LakesMac on 15/11/17.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCFriendRequestListButton.h"

@interface YCFriendRequestListButton ()

@property (nonatomic,strong) UIButton *tipsButton;

@end

@implementation YCFriendRequestListButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor clearColor];
    
    self.tipsButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.tipsButton setTitle:@"收到好友请求" forState:(UIControlStateNormal)];
    [self.tipsButton setTintColor:[UIColor lightGrayColor]];
    self.tipsButton.frame = self.bounds;
    [self addSubview:self.tipsButton];
    [self.tipsButton addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.hidden = YES;
}

- (void)buttonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendRequestListButtonTouchUpInside)]) {
        [self.delegate friendRequestListButtonTouchUpInside];
    }
}
- (void)setHasRequest:(BOOL)hasRequest {
    if (hasRequest) {
        [self show];
    } else {
        [self hidden];
    }
}

- (void)show {
    self.hidden = NO;
}
- (void)hidden {
    self.hidden = YES;
}
@end
