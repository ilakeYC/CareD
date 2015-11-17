//
//  AddFriendView.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "AddFriendView.h"

@implementation AddFriendView

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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.7;
    [self addSubview:view];
    
    self.imageViewShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, CareD_Lake_MainScreenBounds.size.width, CareD_Lake_MainScreenBoundsWithoutNavigationBar.size.height - 12)];
    self.imageViewShadowView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.imageViewShadowView.layer.cornerRadius = 20;
    self.imageViewShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageViewShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.imageViewShadowView.layer.shadowOpacity = 0.7;
    [self addSubview:self.imageViewShadowView];
    
    self.imageViewMasksView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imageViewShadowView.frame.size.width, self.imageViewShadowView.frame.size.width)];
    self.imageViewMasksView.layer.cornerRadius = 20;
    self.imageViewMasksView.layer.masksToBounds = YES;
    [self.imageViewShadowView addSubview:self.imageViewMasksView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.imageViewMasksView.bounds];
    self.imageView.image = [UIImage imageNamed:@"Icon-512"];
    [self.imageViewMasksView addSubview:self.imageView];
    
    
    
    
    self.requestLabelShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageViewMasksView.frame.size.height - 30, self.bounds.size.width, self.imageViewShadowView.frame.size.height - self.imageViewMasksView.frame.size.height + 30)];
    
    self.requestLabelShadowView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.requestLabelShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.requestLabelShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.requestLabelShadowView.layer.shadowOpacity = 0.7;
    
    [self.imageViewShadowView addSubview:self.requestLabelShadowView];
    
}

@end
