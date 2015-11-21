//
//  YCUserImageManager.m
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <AVOSCloudIM.h>
#import "YCUserImageManager.h"
#import "YCUserDefines.h"

@interface YCUserImageManager ()
{
    UIImage *_currentUserImageTemp;
}
@property (nonatomic,strong) NSMutableDictionary *friendListImageListDictionary;
@property (nonatomic,strong) NSMutableDictionary *friendListImageUrlListDictionary;
@property (nonatomic,strong) NSMutableDictionary *userImageUrlUserNamePairs;
@property (nonatomic,strong) NSMutableDictionary *userImageUserNamePairs;

@property (nonatomic,assign) NSInteger numberOfFriends;
@end

@implementation YCUserImageManager

+ (instancetype)sharedUserImage {
    static YCUserImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}


static NSString *const USERIMAGE_CLASSNAME = @"UserImage";

- (void)initUserImageList:(NSString *)userName {
    
    AVObject *userImage = [AVObject objectWithClassName:USERIMAGE_CLASSNAME];
    [userImage setObject:userName forKey:@"userName"];
    [userImage saveInBackground];
}

- (void)setUserImage:(UIImage *)image {
    NSString *userName = [AVUser currentUser].username;
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (objects.count == 0) {
            
        }
        
        AVObject *userImage = [objects firstObject];
        AVFile *oldImageFile = userImage[@"image"];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *newImageFile = [AVFile fileWithName:userName data:imageData];
        [newImageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           
            if (succeeded) {
                
                [userImage setObject:newImageFile forKey:@"image"];
                
                [userImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                   
                    if (succeeded) {
                        self.currentUserImage = image;
//                        NSLog(@"%@",oldImageFile);
#warning - I test to delete ole image to save the spacing of server,if this func is wrong,you coule remove this line down there
                        [oldImageFile deleteInBackground];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(imageUpLoadComplete)]) {
                            [self.delegate imageUpLoadComplete];
                        }
                    } else {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(imageUpLoadFailure)]) {
                            [self.delegate imageUpLoadFailure];
                        }
                    }
                    
                }];
            } else {
                if (self.delegate && [self.delegate respondsToSelector:@selector(imageUpLoadFailure)]) {
                    [self.delegate imageUpLoadFailure];
                }
            }
        } progressBlock:^(NSInteger percentDone) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(imageUpLoadingProgress:)]) {
                [self.delegate imageUpLoadingProgress:percentDone];
            }
        }];
    }];
}

- (void)setUserImage:(UIImage *)image completeBlock:(void (^)(BOOL))successed progress:(void (^)(NSInteger))progress {
    NSString *userName = [AVUser currentUser].username;
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count == 0) {
            
        }
        
        AVObject *userImage = [objects firstObject];
        AVFile *oldImageFile = userImage[@"image"];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *newImageFile = [AVFile fileWithName:userName data:imageData];
        [newImageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {
                
                [userImage setObject:newImageFile forKey:@"image"];
                
                [userImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        self.currentUserImage = image;
                        //                        NSLog(@"%@",oldImageFile);
#warning - I test to delete ole image to save the spacing of server,if this func is wrong,you coule remove this line down there
                        [oldImageFile deleteInBackground];
                        
                        [self resettedUserImage];
                        successed(YES);
                        
                        
                    } else {
                        
                        successed(NO);
                        
                    }
                    
                }];
            } else {
                
                successed(NO);
                
            }
        } progressBlock:^(NSInteger percentDone) {
            
            progress(percentDone);
            
        }];
    }];
}

//下载用户头像
- (void)getCurrentUserImage {
    
    AVUser *currentUser = [AVUser currentUser];
    NSString *userName = currentUser.username;
    
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        AVObject *currentImageObject = [objects firstObject];
        
        AVFile *imageFile = currentImageObject[@"image"];
        
        self.currentUserImageUrl = imageFile.url;
        [imageFile getThumbnail:YES width:1024 height:1024 withBlock:^(UIImage *image, NSError *error) {
            self.currentUserImage = image;
            if (self.delegate && [self.delegate respondsToSelector:@selector(userImageManagerCurrentUserImageDownComplete:)]) {
                [self.delegate userImageManagerCurrentUserImageDownComplete:image];
            }
        }];
    }];
}
//下载当前用户头像地址
- (void)getCurrentUserImageURL {
    AVUser *currentUser = [AVUser currentUser];
    NSString *userName = currentUser.username;
    
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        AVObject *currentImageObject = [objects firstObject];
        
        AVFile *imageFile = currentImageObject[@"image"];
        
        self.currentUserImageUrl = imageFile.url;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(userImageManagerCurrentUserImageURLDownComplete:)]) {
            [self.delegate userImageManagerCurrentUserImageURLDownComplete:imageFile.url];
        }
    }];
}

- (void)getImageUrlWithUser:(AVUser *)user handel:(void (^)(NSString *URL))URL {
    
    NSString *userName = user.username;
    if (!user) {
        return;
    }
#warning ---做了个小优化
    if (self.userImageUrlUserNamePairs[userName]) {
        URL(self.userImageUrlUserNamePairs[userName]);
        return;
    }
    
    
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        AVObject *currentImageObject = [objects firstObject];
        
        AVFile *imageFile = currentImageObject[@"image"];
        NSString *url = imageFile.url;
        if (url) {
            
            [self.userImageUrlUserNamePairs setObject:url forKey:userName];
        }
        URL(url);
        
    }];
}

- (void)setCurrentUserImageUrl:(NSString *)currentUserImageUrl {
    _currentUserImageUrl = currentUserImageUrl;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userImageManagerCurrentUserImageURLDownComplete:)]) {
        [self.delegate userImageManagerCurrentUserImageURLDownComplete:currentUserImageUrl];
    }
}

- (NSArray *)getCurrentUserAllFriends {
    AVUser *currentUser = [AVUser currentUser];
    NSArray *friendListArray = currentUser[@"friends"];
    return friendListArray;
}

//下载所有好友头像
- (void)getCurrentUserFriendImage {
    
    NSArray *friendListArray = [self getCurrentUserAllFriends];
    
    if (!friendListArray) {
        return;
    }
    [self.friendListImageListDictionary addObserver:self forKeyPath:@"count" options:(NSKeyValueObservingOptionNew) context:"dictCount"];
    
    self.numberOfFriends = friendListArray.count;
    
    for (AVUser *user in friendListArray) {
        
        NSString *userName = user.username;
        NSString *userNickName = user[@"nickName"];
        
        AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
        [query whereKey:@"userName" equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            AVObject *currentImageObject = [objects firstObject];
            
            AVFile *imageFile = currentImageObject[@"image"];
            
            [self.friendListImageUrlListDictionary setObject:imageFile.url forKey:userNickName];
            
            [imageFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
                
                [self.friendListImageListDictionary setObject:image forKey:userNickName];
            }];
        }];
    }
}


- (void)getImageWithUser:(AVUser *)user handel:(void (^)(UIImage *))handle {
    
    NSString *userName = user.username;
    if ([userName isEqualToString:[AVUser currentUser].username]) {
        if (_currentUserImageTemp) {
            handle(_currentUserImageTemp);
            return;
        }
    }
    
    if (self.userImageUserNamePairs[userName]) {
        handle(self.userImageUserNamePairs[userName]);
        return;
    }
    
    AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
    [query whereKey:@"userName" equalTo:userName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@",objects);
        AVObject *currentImageObject = [objects firstObject];
        
        AVFile *imageFile = currentImageObject[@"image"];
        
        [imageFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
            NSLog(@"\n%d,\n%s\n",__LINE__,__FUNCTION__);
            _currentUserImage = image;
            if (image) {
                
            [self.userImageUserNamePairs setObject:image forKey:userName];
            }
            handle(image);
        }];
    }];

}
- (void)resettedUserImage {
    _currentUserImageTemp = nil;
    NSString *userName = [AVUser currentUser].username;
    if (self.userImageUrlUserNamePairs[userName]) {
        [self.userImageUrlUserNamePairs removeObjectForKey:userName];
    }
    if (self.userImageUserNamePairs[userName]) {

        [self.userImageUserNamePairs removeObjectForKey:userName];
    }
    
}


- (void)getCurrentUserFriendImageURL {
    NSArray *friendListArray = [self getCurrentUserAllFriends];
    
    if (!friendListArray) {
        return;
    }
    [self.friendListImageListDictionary addObserver:self forKeyPath:@"count" options:(NSKeyValueObservingOptionNew) context:"dictCount"];
    
    self.numberOfFriends = friendListArray.count;
    
    for (AVUser *user in friendListArray) {
        
        NSString *userName = user.username;
        NSString *userNickName = user[@"nickName"];
        
        AVQuery *query = [AVQuery queryWithClassName:USERIMAGE_CLASSNAME];
        [query whereKey:@"userName" equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            AVObject *currentImageObject = [objects firstObject];
            
            AVFile *imageFile = currentImageObject[@"image"];
            [self.friendListImageUrlListDictionary addObserver:self forKeyPath:@"count" options:(NSKeyValueObservingOptionNew) context:@"friendImageURL"];
            [self.friendListImageUrlListDictionary setObject:imageFile.url forKey:userNickName];
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.friendListImageUrlListDictionary.count == self.numberOfFriends) {
        [self.friendListImageUrlListDictionary removeObjectForKey:@"count"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(friendListImageListURLDownLoadComplete:)]) {
            [self.delegate friendListImageListURLDownLoadComplete:self.friendListImageUrlListDictionary];
        }
        
    }
    
    
    if (self.friendListImageListDictionary.count == self.numberOfFriends) {
        [self.friendListImageListDictionary removeObserver:self forKeyPath:@"count" context:@"dictCount"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(friendListImageListDownLoadComplete)]) {
            [self.delegate friendListImageListDownLoadComplete];
        }
    }
}

///用户好友头像列表懒加载
- (NSMutableDictionary *)friendListImageListDictionary{
    if (!_friendListImageListDictionary) {
        _friendListImageListDictionary = [NSMutableDictionary dictionary];
    }
    return _friendListImageListDictionary;
}
- (NSMutableDictionary *)friendListImageUrlListDictionary{
    if (!_friendListImageUrlListDictionary) {
        _friendListImageUrlListDictionary = [NSMutableDictionary dictionary];
    }
    return _friendListImageUrlListDictionary;
}

- (NSMutableDictionary *)userImageUrlUserNamePairs {
    if (!_userImageUrlUserNamePairs) {
        _userImageUrlUserNamePairs = [NSMutableDictionary dictionary];
    }
    return _userImageUrlUserNamePairs;
}
- (NSMutableDictionary *)userImageUserNamePairs {
    if (!_userImageUserNamePairs) {
        _userImageUserNamePairs = [NSMutableDictionary dictionary];
    }
    return _userImageUserNamePairs;
}
@end
