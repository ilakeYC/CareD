//
//  FriendRequestsListViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/17.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "FriendRequestsListViewController.h"
#import "FriendRequestsListView.h"
#import "YCSearchUserCell.h"

@interface FriendRequestsListViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSMutableDictionary *allRequestDictionary;
@property (nonatomic,strong) NSMutableArray *allUserArrey;


@property (nonatomic,strong) FriendRequestsListView *friendRequestsListView;

@end

@implementation FriendRequestsListViewController

- (void)loadView {
    self.friendRequestsListView = [[FriendRequestsListView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.friendRequestsListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.allUserArrey removeAllObjects];
    NSDictionary *dict = [YCUserFriendRequestManager sharedUserFriendRequestManager].requestListDic;
    for (NSString *userName in dict) {
        [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserName:userName result:^(AVUser *user) {
            
            [self.allUserArrey addObject:user];
            
            [self.allRequestDictionary setObject:dict[userName] forKey:user.username];
            [self.allRequestDictionary addObserver:self forKeyPath:@"count" options:(NSKeyValueObservingOptionNew) context:nil];
            [self.friendRequestsListView.tableView reloadData];
        }];
    }
    
    
    self.friendRequestsListView.tableView.delegate = self;
    self.friendRequestsListView.tableView.dataSource = self;
    
    [self.friendRequestsListView.tableView registerNib:[UINib nibWithNibName:@"YCSearchUserCell" bundle:nil] forCellReuseIdentifier:@"searchUserCell"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (self.allRequestDictionary.count == [YCUserFriendRequestManager sharedUserFriendRequestManager].requestListDic.count) {
        [self.friendRequestsListView.tableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if ([YCUserFriendRequestManager sharedUserFriendRequestManager].requestListDic.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UITabelViewDelegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allUserArrey.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCSearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchUserCell" forIndexPath:indexPath];
    
    AVUser *user = self.allUserArrey[indexPath.row];
    
    cell.user = user;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 82;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AVUser *user = self.allUserArrey[indexPath.row];
    
    NSString *password = self.allRequestDictionary[user.username];
    
    FriendRequestViewController *friendRequestVC = [FriendRequestViewController new];
    friendRequestVC.password = password;
    friendRequestVC.user = user;
    
    [self.navigationController pushViewController:friendRequestVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}







- (NSMutableDictionary *)allRequestDictionary {
    if (!_allRequestDictionary) {
        _allRequestDictionary = [NSMutableDictionary dictionary];
    }
    return _allRequestDictionary;
}
- (NSMutableArray *)allUserArrey{
    if (!_allUserArrey) {
        _allUserArrey = [NSMutableArray array];
    }
    return _allUserArrey;
}
@end
