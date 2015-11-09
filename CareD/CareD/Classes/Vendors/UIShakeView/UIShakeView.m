//
//  UIShakeView.m
//  随便
//
//  Created by LakesMac on 15/9/2.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "UIShakeView.h"

@implementation UIShakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)shake{
    
    [self shakeAnimationForView:self];
    
}

-(void)shakeAnimationForView:(UIView *)view{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x+10, position.y);
    CGPoint y = CGPointMake(position.x-10, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
    
    
}













@end
