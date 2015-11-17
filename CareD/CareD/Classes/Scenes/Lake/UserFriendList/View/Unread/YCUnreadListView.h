//
//  YCUnreadListView.h
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YCUnreadListViewDelegate;

@interface YCUnreadListView : UIView

@property (nonatomic,assign) id<YCUnreadListViewDelegate> delegate;

@property (nonatomic,assign) NSInteger numberOfUnread;


@end

@protocol YCUnreadListViewDelegate <NSObject>

- (void)unreadListViewTouchedUpInside:(YCUnreadListView *)unreadListView;

@end