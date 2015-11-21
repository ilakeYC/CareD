//
//  YCFriendListView.h
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCollectionViewCell)(Green_ChatViewController *);
typedef void(^SelectedTableViewCell)(HYFriendInfoViewController *);

@interface YCFriendListView : UIView

@property (nonatomic,copy)SelectedCollectionViewCell selectedCollectionViewCellBlock;
@property (nonatomic,copy)SelectedTableViewCell selectedTableViewCellBlock;

- (void)showTableListView;
- (void)showCircleListView;

//- (void)collectionViewCellSelectedItem:(void(^)(Green_ChatViewController *vc))handle;
//- (void)tableViewCellSelectedCell:(void (^)(Green_ChatViewController *))handle;

@property (nonatomic,strong) NSArray *friendArray;
- (void)loadFriendCaredTop5;

@end
