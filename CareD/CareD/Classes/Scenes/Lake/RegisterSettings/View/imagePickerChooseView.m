//
//  imagePickerChooseView.m
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "imagePickerChooseView.h"

@interface imagePickerChooseView ()

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIVisualEffectView *mainVisualEffectView;

@property (nonatomic,strong) UIView *buttonView;

@property (nonatomic,strong) UIButton *photoBookButton;
@property (nonatomic,strong) UIButton *cameraButton;
@property (nonatomic,strong) UILabel *photoBookLabel;
@property (nonatomic,strong) UILabel *cameraLabel;
@end

@implementation imagePickerChooseView


- (void)showAndClickedButtonAtIndex:(void (^)(NSInteger *))handle {
    
    self.window = [[UIWindow alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    self.window.alpha = 0;
    [self.window makeKeyAndVisible];
    
    
    self.contentView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.window addSubview:self.contentView];
    
    
    self.mainVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.mainVisualEffectView.frame = self.window.bounds;
    [self.contentView addSubview:self.mainVisualEffectView];
    
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width * 0.618, CareD_Lake_MainScreenBounds.size.width * 0.618 * 0.5)];
    self.buttonView.center = self.window.center;
    self.buttonView.layer.cornerRadius = 20;
    self.buttonView.layer.masksToBounds = YES;
    self.buttonView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [self.contentView addSubview:self.buttonView];
    
    self.photoBookButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.photoBookButton setImage:[UIImage imageNamed:@"photoBook"] forState:(UIControlStateNormal)];
    [self.photoBookButton setTintColor:[UIColor whiteColor]];
    self.photoBookButton.frame = CGRectMake(0, 0, self.buttonView.frame.size.width / 5, self.buttonView.frame.size.width / 5);
    self.photoBookButton.center = CGPointMake(self.buttonView.frame.size.width / 4, self.buttonView.frame.size.height / 2);
    [self.buttonView addSubview:self.photoBookButton];
    
    self.cameraButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.cameraButton setImage:[UIImage imageNamed:@"camera"] forState:(UIControlStateNormal)];
    [self.cameraButton setTintColor:[UIColor whiteColor]];
    self.cameraButton.frame = self.photoBookButton.bounds;
    self.cameraButton.center = CGPointMake(self.buttonView.frame.size.width / 4 * 3, self.buttonView.frame.size.height / 2)
    ;
    [self.buttonView addSubview:self.cameraButton];
    
    self.photoBookLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.photoBookButton.frame.origin.x, self.photoBookButton.frame.origin.y + self.photoBookButton.frame.size.height, self.photoBookButton.frame.size.width, self.photoBookButton.frame.size.height)];
    self.photoBookLabel.text = @"从相册";
    self.photoBookLabel.textColor = [UIColor whiteColor];
    self.photoBookLabel.textAlignment = NSTextAlignmentCenter;
    self.photoBookLabel.font = [UIFont systemFontOfSize:12];
    [self.buttonView addSubview:self.photoBookLabel];
    
    self.cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.cameraButton.frame.origin.x, self.cameraButton.frame.origin.y + self.cameraButton.frame.size.height, self.cameraButton.frame.size.width, self.cameraButton.frame.size.height)];
    self.cameraLabel.text = @"从相机";
    self.cameraLabel.textColor = [UIColor whiteColor];
    self.cameraLabel.textAlignment = NSTextAlignmentCenter;
    self.cameraLabel.font = [UIFont systemFontOfSize:12];
    [self.buttonView addSubview:self.cameraLabel];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self.contentView addGestureRecognizer:tap];
    
    [self.cameraButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.photoBookButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.window.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)hidden {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window resignKeyWindow];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidden];
}

- (void)buttonAction:(UIButton *)sender {
    
    [self hidden];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonAtIndex:)]) {
        if (sender == self.photoBookButton) {
            [self.delegate clickButtonAtIndex:0];
        } else {
            [self.delegate clickButtonAtIndex:1];
        }
    }
}




@end
