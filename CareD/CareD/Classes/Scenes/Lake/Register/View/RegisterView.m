
//
//  RegisterView.m
//  CareD
//
//  Created by LakesMac on 15/11/9.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

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
    self.registerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RegisterImage"]];
    self.registerImageView.frame = CGRectMake(0, 0, 375, 667);
    self.registerImageView.center = CGPointMake(CareD_Lake_MainScreenBounds.size.width / 2, CareD_Lake_MainScreenBounds.size.height / 2);
    [self addSubview:self.registerImageView];
}

@end
