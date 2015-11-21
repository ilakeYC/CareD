
//
//  Green_BackImageViewController.m
//  CareD
//
//  Created by 慈丽娟 on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "Green_BackImageViewController.h"
#import "Green_backIamgeCell.h"

@interface Green_BackImageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation Green_BackImageViewController
static NSString * const cellID = @"backCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
//     上左下右
    flowLayout.sectionInset = UIEdgeInsetsMake(50, 20, 30, 20);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 60) / 3, ([UIScreen mainScreen].bounds.size.width - 60) / 3 + 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:flowLayout];
    ;
//     注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"Green_backIamgeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
     self.collectionView.backgroundColor = [UIColor whiteColor];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    Green_backIamgeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID  forIndexPath:indexPath];
    cell.imagName = [NSString stringWithFormat:@"image%ld",indexPath.item];
    
    //     取出是哪个图片
    NSString * key =@"GreenFriendBackImage";
    key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSInteger index = number.integerValue;
    // 设置button
    if (index == indexPath.item) {
        [cell.button setHidden:NO];
    }else{
        [cell.button setHidden:YES];
    }
       return cell;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//     每次点击之前清空上一次的 (先取出)
    NSString * key =@"GreenFriendBackImage";
    key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSInteger index = number.integerValue;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    Green_backIamgeCell * cell = (Green_backIamgeCell *)[collectionView cellForItemAtIndexPath:newIndexPath];
    [cell.button setHidden:YES];
    
//     被点击后 button 显示出来
      Green_backIamgeCell * newCell = (Green_backIamgeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [newCell.button setHidden:NO];
    
//   点击后存到NSUserDefaults
    NSNumber * newNumber = [NSNumber numberWithInteger:indexPath.item];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:newNumber forKey:key];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
