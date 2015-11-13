//
//  FriendListViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendListViewController.h"
#import "FriendListView.h"

@interface FriendListViewController ()

@property (nonatomic,strong) FriendListView *friendListView;

@end

@implementation FriendListViewController

- (void)loadView {
    self.friendListView = [[FriendListView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.friendListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

@end
