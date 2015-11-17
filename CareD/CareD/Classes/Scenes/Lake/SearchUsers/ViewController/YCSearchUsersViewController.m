//
//  YCSearchUsersViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCSearchUsersViewController.h"
#import "YCSearchUsersView.h"
#import "YCSearchUserCell.h"

@interface YCSearchUsersViewController ()<UISearchBarDelegate,YCUserFriendsManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_resultArray;
}
@property (nonatomic,strong) YCSearchUsersView *searchUsersView;

@end

@implementation YCSearchUsersViewController

- (void)loadView {
    self.searchUsersView = [[YCSearchUsersView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.searchUsersView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.searchUsersView.searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(backToLastVC)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.searchUsersView.tableView.delegate = self;
    self.searchUsersView.tableView.dataSource = self;
    self.searchUsersView.searchBar.delegate = self;
    
    [self.searchUsersView.tableView registerNib:[UINib nibWithNibName:@"YCSearchUserCell" bundle:nil] forCellReuseIdentifier:@"searchUserCell"];
    
    [YCUserFriendsManager sharedFriendsManager].delegate = self;
}
- (void)backToLastVC {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITabelViewDelegate & dataSources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCSearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchUserCell" forIndexPath:indexPath];
    AVUser *user = _resultArray[indexPath.row];
    cell.user = user;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCSearchUserCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self.searchUsersView.searchBar resignFirstResponder];
    if ([[YCUserFriendsManager sharedFriendsManager] userIsFriend:_resultArray[indexPath.row]]) {
        
        //是好友时候页面
        
    } else {
        
        
        
        AddFriendViewController *addFriendVC = [AddFriendViewController new];
        addFriendVC.image = cell.image;
        addFriendVC.user  = cell.user;
        [self.navigationController pushViewController:addFriendVC animated:YES];
        
        //不是好友时候界面
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        return;
    }
    [[YCUserFriendsManager sharedFriendsManager] searchFriendByNickName:searchText];
}

#pragma mark - YCUserFriendManager Delegate 
- (void)userFriendsManagerFriendSearchByNickName:(NSString *)nickName complete:(NSArray *)friendList {
    _resultArray = friendList;
    
    if (_resultArray.count == 0) {
        [self.searchUsersView showTipsLabel];
    } else {
        [self.searchUsersView hiddenTipsLabel];
    }
    
    [self.searchUsersView.tableView reloadData];
}
@end
