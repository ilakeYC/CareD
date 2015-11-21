//
//  YCUserImageManager.h
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol YCUserImageManagerDelegate <NSObject>

@optional

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
///用户头像下载完成
- (void)userImageManagerCurrentUserImageDownComplete:(UIImage *)image;
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
///设置用户头像
- (void)setUserImage:(UIImage *)image completeBlock:(void(^)(BOOL successed))successed progress:(void(^)(NSInteger progress))progress;


///下载用户头像
- (void)getCurrentUserImage;
- (void)getCurrentUserImageURL;
///下载所有好友
- (NSArray *)getCurrentUserAllFriends;
///下载好友列表头像
- (void)getCurrentUserFriendImage;
///下载好友头像ULR
- (void)getCurrentUserFriendImageURL;
///按照用户下载头像地址
- (void)getImageUrlWithUser:(AVUser *)user handel:(void(^)(NSString *URL))URL;
///下载用户头像缩略图
- (void)getImageWithUser:(AVUser *)user handel:(void(^)(UIImage *image))handle;

- (void)resettedUserImage;
@end
