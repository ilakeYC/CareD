//
//  UnreadTipView.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UnreadTipView.h"

@interface UnreadTipView ()
{
    NSInteger _timerCount;
    NSTimer   *_time;
}
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIWindow *window;

@end

@implementation UnreadTipView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.label = [UILabel new];
    }
    return self;
}
+ (instancetype)prepareNotifaction {
    static UnreadTipView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [self new];
    });
    return view;
}

- (void)setUserNickName:(NSString *)userNickName {
    _userNickName = userNickName;
    
    self.window = [[UIWindow alloc] initWithFrame: CGRectMake(0, -20, CareD_Lake_MainScreenBounds.size.width, 20)];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    [self.window makeKeyAndVisible];
    
    
    self.label.frame = self.window.bounds;
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.window.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [self.window addSubview:self.label];
    
    
    
    self.label.text = [NSString stringWithFormat:@"CareD 提示：好友 %@ 发来一条信息",userNickName];
    [self show];
}

- (void)setTipsText:(NSString *)tipsText {
    
    self.window = [[UIWindow alloc] initWithFrame: CGRectMake(0, -20, CareD_Lake_MainScreenBounds.size.width, 20)];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    [self.window makeKeyAndVisible];
    
    
    self.label.frame = self.window.bounds;
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.window.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [self.window addSubview:self.label];
    
    
    
    self.label.text = tipsText;
    [self show];
}

- (void)show {
    _timerCount = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
    CGRect frame = self.window.frame;
    frame.origin.y = 0;
    self.window.frame = frame;
    }];
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hidden) userInfo:nil repeats:YES];
}
- (void)hidden {
    if (_timerCount <= 2) {
        _timerCount ++;
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.window.frame;
        frame.origin.y = -20;
        self.window.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_time invalidate];
            _time = nil;
            [self.window resignKeyWindow];
            self.window = nil;
        }
    }];
    
    
}

@end
