//
//  YCFuncListView.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCFuncListView.h"

@interface YCFuncListView ()

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIVisualEffectView *effectView;


@property (nonatomic,strong) UIButton *searchFriendsButton;
@property (nonatomic,strong) UIButton *scanButton;
@end

@implementation YCFuncListView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)showButtonList {
    [self makeAllViews];
}

- (void)makeAllViews {
    self.window = [[UIWindow alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    [self.window makeKeyAndVisible];
    
    self.contentView = [[UIView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:self.contentView];
    
    self.shadowView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.shadowView.backgroundColor = [UIColor darkGrayColor];
    self.shadowView.alpha = 0;
    [self.contentView addSubview:self.shadowView];
    
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.effectView.frame = CGRectMake(self.contentView.frame.size.width, 0, 49, self.contentView.frame.size.height);
    
    [self.contentView addSubview:self.effectView];
    
    
    UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width - 49, self.contentView.frame.size.height)];
    [self.contentView addSubview:tapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenButtonList)];
    [tapView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.shadowView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.2 animations:^{
               
                CGRect effectViewFrame = self.effectView.frame;
                effectViewFrame.origin.x = self.contentView.frame.size.width - 49;
                self.effectView.frame = effectViewFrame;
                
            } completion:^(BOOL finished) {
                if (finished) {
                    
                    [self showButtons];
                    
                }
            }];
        }
    }];
    
}

- (void)showButtons {
    
    UIView *searchFriendsView = [[UIView alloc] initWithFrame:CGRectMake(49, 40, 39, 53)];
    [self.effectView addSubview:searchFriendsView];
    
    self.searchFriendsButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.searchFriendsButton setImage:[UIImage imageNamed:@"searchFriends"] forState:(UIControlStateNormal)];
    [self.searchFriendsButton setTintColor:[UIColor whiteColor]];
    self.searchFriendsButton.frame = CGRectMake(0, 0, 39, 39);
    [self.searchFriendsButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [searchFriendsView addSubview:self.searchFriendsButton];
    
    UILabel *searchFriendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, 39, 14)];
    searchFriendsLabel.font = [UIFont systemFontOfSize:7];
    searchFriendsLabel.text = @"查找在乎的";
    searchFriendsLabel.textColor = [UIColor whiteColor];
    searchFriendsLabel.textAlignment = NSTextAlignmentCenter;
    [searchFriendsView addSubview:searchFriendsLabel];
    
    
    UIView *scanView = [[UIView alloc] initWithFrame:CGRectMake(49, 133, 39, 53)];
    [self.effectView addSubview:scanView];
    
    self.scanButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.scanButton setImage:[UIImage imageNamed:@"scan"] forState:(UIControlStateNormal)];
    [self.scanButton setTintColor:[UIColor whiteColor]];
    self.scanButton.frame = self.searchFriendsButton.bounds;
    [self.scanButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [scanView addSubview:self.scanButton];
    
    UILabel *scanLabel = [[UILabel alloc] initWithFrame:searchFriendsLabel.frame];
    scanLabel.font = [UIFont systemFontOfSize:7];
    scanLabel.textColor = [UIColor whiteColor];
    scanLabel.textAlignment = NSTextAlignmentCenter;
    scanLabel.text = @"扫一扫";
    [scanView addSubview:scanLabel];
    
    
    
    [UIView animateWithDuration:0.1 animations:^{
        searchFriendsView.frame = CGRectMake(5, 40, 39, 53);
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                scanView.frame = CGRectMake(5, 133, 39, 53);
                
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                }
                
            }];
        }
        
    }];
    
}

- (void)buttonAction:(UIButton *)sender {
    
    if (sender == self.searchFriendsButton) {
        [self touchedButtonAtIndex:0];
    } else if (sender == self.scanButton) {
        [self touchedButtonAtIndex:1];
    }
    
}
- (void)touchedButtonAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(funcListViewTouchedButtonAtIndex:)]) {
        [self.delegate funcListViewTouchedButtonAtIndex:index];
    }
}


- (void)hiddenButtonList {
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect effectViewFrame = self.effectView.frame;
        effectViewFrame.origin.x = self.contentView.frame.size.width;
        self.effectView.frame = effectViewFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.window.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.window resignKeyWindow];
                }
            }];
        }
    }];
    
}
@end
