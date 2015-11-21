//
//  YCFriendListView.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCFriendListView.h"
#import "RGCardViewLayout.h"
#import "CircleListCell.h"
#import "tableListCell.h"

@interface YCFriendListView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *circleListContentView;
@property (nonatomic,strong) UIView *tableListContentView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (atomic,strong) NSMutableArray *top5Array;

@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) UIView *tableViewTipImageBackView;
@property (nonatomic,strong) UIImageView *tableViewTipImageView;
@property (nonatomic,strong) UIView *collectionViewTipImageBackView;
@property (nonatomic,strong) UIImageView *collectionViewTipImageView;
@end

@implementation YCFriendListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

static NSString *const circleCellID = @"circleCell";
static NSString *const tableListCellID = @"tableListCell";

- (void)addAllViews{
    
    self.backgroundColor = [UIColor whiteColor];
    self.circleListContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.circleListContentView];
    
    self.tableListContentView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:self.tableListContentView];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableListContentView.bounds style:(UITableViewStylePlain)];
    [self.tableListContentView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"tableListCell" bundle:nil] forCellReuseIdentifier:tableListCellID];
    
    
    self.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 49)];
        view;
    });
    
    
    RGCardViewLayout *layout = [[RGCardViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.circleListContentView.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.circleListContentView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.alwaysBounceVertical = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CircleListCell" bundle:nil] forCellWithReuseIdentifier:circleCellID];
    
    
    self.tableViewTipImageBackView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    self.tableViewTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendListTip"]];
    self.tableViewTipImageView.frame = self.tableViewTipImageBackView.bounds;
    [self.tableViewTipImageBackView addSubview:self.tableViewTipImageView];
    self.tableViewTipImageView.hidden = YES;
    
    self.tableView.backgroundView = self.tableViewTipImageBackView;
    
    
    self.collectionViewTipImageBackView = [[UIView alloc] initWithFrame:self.collectionView.bounds];
    self.collectionViewTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FriendListCollectionTips"]];
    self.collectionViewTipImageView.frame = self.collectionViewTipImageBackView.bounds;
    [self.collectionViewTipImageBackView addSubview:self.collectionViewTipImageView];
    self.collectionViewTipImageView.hidden = YES;
    self.collectionView.backgroundView = self.collectionViewTipImageBackView;
    
}


- (void)showCircleListView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect tableFrame = self.tableListContentView.frame;
    tableFrame.origin.x = self.bounds.size.width;
    self.tableListContentView.frame = tableFrame;
    
    CGRect circleFrame = self.circleListContentView.frame;
    circleFrame.origin.x = 0;
    self.circleListContentView.frame = circleFrame;
    
    [UIView commitAnimations];
    
    [self.collectionView reloadData];
}
- (void)showTableListView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect tableFrame = self.tableListContentView.frame;
    tableFrame.origin.x = 0;
    self.tableListContentView.frame = tableFrame;
    
    CGRect circleFrame = self.circleListContentView.frame;
    circleFrame.origin.x = -self.bounds.size.width;
    self.circleListContentView.frame = circleFrame;
    
    [UIView commitAnimations];
    
    [self.tableView reloadData];
}

- (void)setFriendArray:(NSArray *)friendArray {
    _friendArray = friendArray;
    
    [self.tableView reloadData];
    
    
    
    
//    [self.collectionView reloadData];
}

- (void)loadFriendCaredTop5 {
    
    NSArray *array = [Green_ChatManage findFiveFriends];
//     先清除
    NSMutableArray *top5 = [NSMutableArray array];
    
//    NSMutableArray *tempArray = [NSMutableArray array];
    
//    [self.top5Array removeAllObjects];
    
//    if (!array || array.count == 0) {
//        if (_friendArray.count !=0) {
//            [self.top5Array addObject:[_friendArray firstObject]];
//        }
//    }
    
    for (NSString *userNameForChat in array) {
        
        [[YCUserFriendsManager sharedFriendsManager] searchFriendByUserNameForChat:userNameForChat result:^(AVUser *user){
            if (user) {
                BOOL flag = YES;
                for (AVUser *elu in self.top5Array) {
                    if ([elu.username isEqualToString:user.username]) {
                        flag = NO;
                    }
                }
                if (flag) {
                    [self.top5Array addObject:user];
                    //             刷新数据
                    [self.collectionView reloadData];
                }
            }
        }];
    }
}

#pragma mark - collection view delegate 集合视图代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.top5Array.count == 0) {
        self.collectionViewTipImageView.hidden = NO;
    } else {
        self.collectionViewTipImageView.hidden = YES;
    }
    return  self.top5Array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:circleCellID forIndexPath:indexPath];
    NSLog(@"item ====== %ld,row ==== %ld , section == %ld",indexPath.item,indexPath.row,indexPath.section);
    cell.user = self.top5Array[indexPath.section];
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(305, 379);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//     点击最近好友， 直接聊天
    Green_ChatViewController * chatVC = [[Green_ChatViewController alloc]init];
//     赋值
    CircleListCell *cell = (CircleListCell *)[collectionView cellForItemAtIndexPath:indexPath];
    AVUser * friendUser = cell.user;
    NSString *userNameForToken = friendUser[CARED_LEANCLOUD_USER_userNameForChat];
    NSString *userName = friendUser[@"nickName"];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = userNameForToken;
    chatVC.userName = userName;
    chatVC.title = userName;
    
//      block 在主控制器中跳转
    self.selectedCollectionViewCellBlock(chatVC);
}



#pragma mark - table view delegate 表视图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_friendArray.count == 0) {
        self.tableViewTipImageView.hidden = NO;
    } else {
        self.tableViewTipImageView.hidden = YES;
    }
    return _friendArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableListCellID forIndexPath:indexPath];
    
    cell.user = _friendArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning - case this func that useing block to push viewController , change that class as your custom class
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYFriendInfoViewController *friendInfoVC = [HYFriendInfoViewController new];
    
    friendInfoVC.user = _friendArray[indexPath.row];
    
    self.selectedTableViewCellBlock(friendInfoVC);
    
}

- (NSMutableArray *)top5Array {
    if (!_top5Array) {
        _top5Array = [NSMutableArray arrayWithCapacity:5];
    }
    return _top5Array;
}
@end
