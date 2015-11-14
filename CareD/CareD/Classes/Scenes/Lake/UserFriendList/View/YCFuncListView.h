//
//  YCFuncListView.h
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCFuncListViewDelegate;

@interface YCFuncListView : UIView

@property (nonatomic,assign) id<YCFuncListViewDelegate> delegate;

- (void)showButtonList;

@end

@protocol YCFuncListViewDelegate <NSObject>

- (void)funcListViewTouchedButtonAtIndex:(NSInteger)index;

@end