//
//  UnreadTipView.h
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnreadTipView : UIView

@property (nonatomic,strong) NSString *userNickName;

- (void)show;
- (void)hidden;

@end
