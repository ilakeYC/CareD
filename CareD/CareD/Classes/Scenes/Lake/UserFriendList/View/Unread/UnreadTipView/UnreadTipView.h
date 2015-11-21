//
//  UnreadTipView.h
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnreadTipView : UIView

+ (instancetype)prepareNotifaction;

@property (nonatomic,strong) NSString *userNickName;
@property (nonatomic,strong) NSString *tipsText;

- (void)show;
- (void)hidden;

@end
