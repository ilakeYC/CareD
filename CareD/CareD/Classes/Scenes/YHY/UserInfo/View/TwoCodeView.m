//
//  TwoCodeView.m
//  CareD
//
//  Created by LakesMac on 15/11/20.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "TwoCodeView.h"

@interface TwoCodeView ()

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIView *twoCodeView;
@property (nonatomic,strong) Green_MakeTwoCodeView *twoCodeMaker;
@end

@implementation TwoCodeView

- (void)showView {
    self.window = [[UIWindow alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.window.windowLevel = UIWindowLevelAlert + 2;
    
    self.contentView = [[UIView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:self.contentView];
    
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)]];
    self.effectView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.effectView];
    
    self.twoCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.twoCodeView.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, CareD_Lake_MainScreenBounds.size.height / 2);
    [self.contentView addSubview:self.twoCodeView];
    
    NSString *userNameForScan = [AVUser currentUser][CARED_LEANCLOUD_USER_userNameForScan];
    
    self.twoCodeMaker = [[Green_MakeTwoCodeView alloc] initWithTwoCodeString:userNameForScan logoImage:nil viewframe:self.twoCodeView.bounds];
    [self.twoCodeView addSubview:self.twoCodeMaker];
    
    [self.window makeKeyAndVisible];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.twoCodeView.frame.size.height + self.twoCodeView.frame.origin.y + 20, self.contentView.frame.size.width, 60)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"通过另一台设备的CareD扫描此二维码\n可以添加您为好友";
    [self.contentView addSubview:label];
    
    
    self.twoCodeView.alpha = 0;
    self.contentView.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    [self.contentView addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.twoCodeView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
    
    
}

- (void)hiddenView {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.window resignKeyWindow];
            self.window = nil;
        }
    }];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"\n%d,\n%s\n",__LINE__,__FUNCTION__);
    [self hiddenView];
}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self hiddenView];
//}


@end
