//
//  UserImageView.h
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserImageViewDelegate;

@interface UserImageView : UIImageView

@property (nonatomic,assign) id<UserImageViewDelegate> delegate;

@end

@protocol UserImageViewDelegate <NSObject>

- (void)userImageViewTouchUpInSide;

@end
