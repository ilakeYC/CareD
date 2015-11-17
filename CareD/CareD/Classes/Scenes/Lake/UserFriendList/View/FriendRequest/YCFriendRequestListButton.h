//
//  YCFriendRequestListButton.h
//  CareD
//
//  Created by LakesMac on 15/11/17.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCFriendRequestListButtonDelegate;

@interface YCFriendRequestListButton : UIView

@property (nonatomic,assign) id<YCFriendRequestListButtonDelegate> delegate;

@property (nonatomic,assign) BOOL hasRequest;

@end


@protocol YCFriendRequestListButtonDelegate <NSObject>

- (void)friendRequestListButtonTouchUpInside;

@end