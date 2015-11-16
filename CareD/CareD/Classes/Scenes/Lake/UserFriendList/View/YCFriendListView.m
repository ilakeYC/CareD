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


@property (nonatomic,strong) UITableView *tableView;

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"tableListCell" bundle:nil] forCellReuseIdentifier:tableListCellID];
    
    
    self.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 49)];
        view;
    
    
    });
    
    
    RGCardViewLayout *layout = [[RGCardViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.circleListContentView.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];    [self.circleListContentView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CircleListCell" bundle:nil] forCellWithReuseIdentifier:circleCellID];
    
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


#pragma mark - collection view delegate 集合视图代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:circleCellID forIndexPath:indexPath];
    
    NSLog(@"%@",NSStringFromCGRect(cell.bounds));
    return cell;
}

#pragma mark - table view delegate 表视图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableListCellID forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
@end
