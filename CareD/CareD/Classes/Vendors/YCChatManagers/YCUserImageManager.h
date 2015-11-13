//
//  YCUserImageManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol YCUserImageManagerDelegate <NSObject>

///上传进度
- (void)imageUpLoadingProgress:(NSInteger)percent;
///上传成功
- (void)imageUpLoadComplete;
///上传失败
- (void)imageUpLoadFailure;

///好友头像列表下载完成
- (void)friendListImageListDownLoadComplete;
///好友头像列表url下载完成(字典键值为好友昵称)
- (void)friendListImageListURLDownLoadComplete:(NSDictionary *)dictionary;

///用户头像url下载完成
- (void)userImageManagerCurrentUserImageURLDownComplete:(NSString *)url;

@end

@interface YCUserImageManager : NSObject

@property (nonatomic,strong) UIImage *currentUserImage;
@property (nonatomic,copy) NSString *currentUserImageUrl;

@property (nonatomic,assign) id<YCUserImageManagerDelegate> delegate;

+ (instancetype)sharedUserImage;

///初始化存储节点
- (void)initUserImageList:(NSString *)userName;

///设置用户头像
- (void)setUserImage:(UIImage *)image;

///下载用户头像
- (void)getCurrentUserImage;
///下载所有好友
- (NSArray *)getCurrentUserAllFriends;
///下载好友列表头像
- (void)getCurrentUserFriendImage;

@end
