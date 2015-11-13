//
//  FriendListView.m
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendListView.h"

@implementation FriendListView

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
    
    self.contentView = [[UIView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar];
    [self addSubview:self.contentView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.7;
    [self.contentView addSubview:view];
    
    self.userInfoBarBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CareD_Lake_MainScreenBoundsWithoutNavigationBar.size.height - 98, CareD_Lake_MainScreenBounds.size.width, 98)];
    self.userInfoBarBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.userInfoBarBackView];
    
    self.userInfoBar = [[UIView alloc] initWithFrame:CGRectMake(0, 49, self.userInfoBarBackView.frame.size.width, 49)];
    self.userInfoBar.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.userInfoBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.userInfoBar.layer.shadowOpacity = 0.7;
    self.userInfoBar.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.userInfoBarBackView addSubview:self.userInfoBar];
    
    
    
    
    self.userImageMainBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 98, 98)];
    self.userImageMainBackView.center = CGPointMake(self.userInfoBarBackView.frame.size.width / 2, self.userInfoBarBackView.frame.size.height / 2);
    self.userImageMainBackView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.userImageMainBackView.layer.cornerRadius = self.userImageMainBackView.frame.size.height / 2;
    self.userImageMainBackView.layer.masksToBounds = YES;
    [self.userInfoBarBackView addSubview:self.userImageMainBackView];
    
    
    self.userImageBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userImageMainBackView.frame.size.width - 12, self.userImageMainBackView.frame.size.height - 12)];
    self.userImageBackView.center = CGPointMake(self.userImageMainBackView.frame.size.width / 2, self.userImageMainBackView.frame.size.height / 2);
    self.userImageBackView.backgroundColor = [UIColor whiteColor];
    self.userImageBackView.layer.cornerRadius = self.userImageBackView.frame.size.height / 2;
    self.userImageBackView.layer.masksToBounds = YES;
    [self.userImageMainBackView addSubview:self.userImageBackView];
}

@end
