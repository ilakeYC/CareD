//
//  YCSearchUsersView.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCSearchUsersView.h"

@implementation YCSearchUsersView

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
    

    
    self.tableView = [[UITableView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.7;
    [self addSubview:view];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0, CareD_Lake_MainScreenBounds.size.width - 40, 30)];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    
    
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width, 100)];
    self.tipsLabel.textColor = [UIColor lightGrayColor];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.text = @"按照昵称查找好友";
    [self addSubview:self.tipsLabel];
    
}

- (void)showTipsLabel {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.tipsLabel.alpha = 1;
    }];
    
}
- (void)hiddenTipsLabel {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.tipsLabel.alpha = 0;
    }];
    
}

@end
