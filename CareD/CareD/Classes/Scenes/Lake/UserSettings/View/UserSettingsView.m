//
//  UserSettingsView.m
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserSettingsView.h"

@implementation UserSettingsView

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
    self.contentView = [[UIView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar];
    [self addSubview:self.contentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar style:(UITableViewStylePlain)];
    
    [self.contentView addSubview:self.tableView];
    
}

@end
