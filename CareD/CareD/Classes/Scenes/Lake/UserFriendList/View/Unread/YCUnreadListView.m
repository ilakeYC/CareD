//
//  YCUnreadListView.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCUnreadListView.h"


@interface YCUnreadListView ()
{
    BOOL _isTouchedInside;
    BOOL _isShow;
}

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *buttonShadowView;
@property (nonatomic,strong) UIView *button;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *label;

@end

@implementation YCUnreadListView

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
    
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.contentView];
    
    self.buttonShadowView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
    self.buttonShadowView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    self.buttonShadowView.layer.cornerRadius = self.buttonShadowView.frame.size.height / 2;
    self.buttonShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonShadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.buttonShadowView.layer.shadowOpacity = 0.7;
    [self.contentView addSubview:self.buttonShadowView];
    
    self.button = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
    self.button.layer.cornerRadius = self.button.frame.size.height / 2;
    self.button.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    [self.contentView addSubview:self.button];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:self.button.bounds];
    self.numberLabel.text = @"3";
    self.numberLabel.adjustsFontSizeToFitWidth = YES;
    self.numberLabel.font = [UIFont systemFontOfSize:22];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.shadowOffset = CGSizeMake(0.5, 1.5);
    self.numberLabel.shadowColor = [UIColor grayColor];
    [self.button addSubview:self.numberLabel];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.button.frame.size.width + self.button.frame.origin.x, self.button.frame.origin.y, self.contentView.frame.size.width - self.button.frame.size.width - self.button.frame.origin.x, self.button.frame.size.height)];
    self.label.text = @"3位好友信息未读";
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.textColor = [UIColor lightGrayColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];


    [self hidden];
}

- (void)setNumberOfUnread:(NSInteger)numberOfUnread {
    _numberOfUnread = numberOfUnread;
    
    if (numberOfUnread == 0) {
        if (_isShow) {
            [self hidden];
        }
        return;
    }
    
    if (!_isShow) {
        [self show];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",numberOfUnread];
    self.label.text = [NSString stringWithFormat:@"%ld位好友信息未读",numberOfUnread];
    
}


- (void)show {
    self.contentView.alpha = 1;
    self.button.backgroundColor = [UIColor whiteColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:INT64_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    self.button.backgroundColor = [UIColor orangeColor];
    //    self.button.alpha = 0.5;
    [UIView commitAnimations];
    _isShow = YES;
}
- (void)hidden {
    [UIView animateWithDuration:1 animations:^{
        self.contentView.alpha = 0;
    }];
    _isShow = NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self];
    CGFloat      x = point.x;
    CGFloat      y = point.y;
    if (x >= 0 && y >= 0 && x <= self.frame.size.width && y <= self.frame.size.height) {
        _isTouchedInside = YES;
    } else {
        _isTouchedInside = NO;
    }
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self];
    CGFloat      x = point.x;
    CGFloat      y = point.y;
    if (x >= 0 && y >= 0 && x <= self.frame.size.width && y <= self.frame.size.height) {
        if (_isTouchedInside) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(unreadListViewTouchedUpInside:)]) {
                [self.delegate unreadListViewTouchedUpInside:self];
            }
            
            
        }
    } else {
        
    }
    
}



@end
