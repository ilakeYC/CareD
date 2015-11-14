//
//  UserImageView.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserImageView.h"

@interface UserImageView ()
{
    BOOL _isTouchInSide;
}
@end

@implementation UserImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (touchLocation.x >= 0 && touchLocation.x <= self.frame.size.width & touchLocation.y >= 0 && touchLocation.y <= self.frame.size.height) {
        _isTouchInSide = YES;
    } else {
        _isTouchInSide = NO;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5;
    }];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (touchLocation.x >= 0 && touchLocation.x <= self.frame.size.width & touchLocation.y >= 0 && touchLocation.y <= self.frame.size.height) {
        
        if (_isTouchInSide) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(userImageViewTouchUpInSide)]) {
                [self.delegate userImageViewTouchUpInSide];
            }
        }
        
    } else {
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}


@end
