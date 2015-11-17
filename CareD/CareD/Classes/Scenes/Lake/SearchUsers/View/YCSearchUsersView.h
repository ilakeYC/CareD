//
//  YCSearchUsersView.h
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSearchUsersView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UILabel *tipsLabel;


- (void)showTipsLabel;
- (void)hiddenTipsLabel;

@end
