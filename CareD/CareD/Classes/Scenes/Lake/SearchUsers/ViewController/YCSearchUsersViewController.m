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

@interface YCSearchUsersViewController ()<UISearchBarDelegate,YCUserFriendsManagerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *_resultArray;
}
@property (nonatomic,strong) YCSearchUsersView *searchUsersView;

@property (nonatomic,strong) UIActivityIndicatorView *juhua;

@end

@implementation YCSearchUsersViewController

- (void)loadView {
    self.searchUsersView = [[YCSearchUsersView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.searchUsersView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *juhuaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    self.juhua.hidesWhenStopped = YES;
    self.juhua.center = juhuaView.center;
    [self.juhua stopAnimating];
    [juhuaView addSubview:self.juhua];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:juhuaView];
    
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
        
        HYFriendInfoViewController *friendInfoVC = [HYFriendInfoViewController new];
        friendInfoVC.user = cell.user;
        [self.navigationController pushViewController:friendInfoVC animated:YES];
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
    [self.juhua startAnimating];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
}// called when keyboard search button pressed

#pragma mark - YCUserFriendManager Delegate 
- (void)userFriendsManagerFriendSearchByNickName:(NSString *)nickName complete:(NSArray *)friendList {
    _resultArray = friendList;
    [self.juhua stopAnimating];
    if (_resultArray.count == 0) {
        [self.searchUsersView showTipsLabel];
    } else {
        [self.searchUsersView hiddenTipsLabel];
    }
    
    [self.searchUsersView.tableView reloadData];
}
@end
