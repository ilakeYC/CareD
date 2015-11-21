//
//  YCUserManager.m
//  聊天测试
//
//  Created by LakesMac on 15/11/11.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <AVOSCloudIM.h>
#import "YCUserManager.h"
#import "YCUserImageManager.h"
#import "YCUserDefines.h"




@interface YCUserManager ()

///代理对象数组
@property (nonatomic,strong) NSMutableSet *delegateSet;

@end

@implementation YCUserManager

+ (instancetype)sharedUserManager {
    static YCUserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (void)addDelegate:(id<YCUserManagerDelegate>)delegate {
    if (!delegate) {
        return;
    }
    [self.delegateSet addObject:delegate];
}

#pragma mark
//_______________用户注册________________________
- (void)registerUser:(NSString *)userName password:(NSString *)password email:(NSString *)email {
    
    NSString *userNameForScan = [self stringByEncryptionFromString:userName];
    NSString *userNameForChat = [self stringByEncryptionFromString:userNameForScan];
    
    AVUser *user = [AVUser user];
    user.username = userName;
    user.password = password;
    user.email    = email;
    [user setObject:userName forKey:@"nickName"];
    [user setObject:userNameForScan forKey:@"userNameForScan"];
    [user setObject:userNameForChat forKey:@"userNameForChat"];
    
    
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterWillRegister)]) {
                [delegate userManagerRegisterWillRegister];
            }
        }
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            [[YCUserImageManager sharedUserImage] initUserImageList:userName];
            
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterUserSuccessed:)]) {
                        [delegate userManagerRegisterUserSuccessed:user];
                    }
                }
                return;
            }
        }
        if (error && _delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterUserFailure:)]) {
                    [delegate userManagerRegisterUserFailure:[self registerError:error]];
                }
            }
        }
        
        
    }];
}

///用户注册并且获得token
- (void)registerUserAndGetToken:(NSString *)userName
                       password:(NSString *)password
                          email:(NSString *)email {
    
    
    NSString *userNameForScan = [self stringByEncryptionFromString:userName];
    NSString *userNameForChat = [self stringByEncryptionFromString:userNameForScan];
    
    AVUser *user = [AVUser user];
    user.username = userName;
    user.password = password;
    user.email    = email;
    [user setObject:userName forKey:@"nickName"];
    [user setObject:userNameForScan forKey:@"userNameForScan"];
    [user setObject:userNameForChat forKey:@"userNameForChat"];
    
    
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterWillRegister)]) {
                [delegate userManagerRegisterWillRegister];
            }
        }
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //初始化头像
            [[YCUserImageManager sharedUserImage] initUserImageList:userName];
            
            //获取token
            [self getRongCloudTokenWithUserId:userNameForChat UserNickName:@"CareD" tokenHandle:^(NSString *token) {
                if ([token isEqualToString:@"错误"]) {
                    //发生错误
                    for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                        if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterUserFailure:)]) {
                            [delegate userManagerRegisterUserFailure:[self registerError:error]];
                        }
                    }
                } else {
                    
                    [user setObject:token forKey:@"token"];
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                       
                        if (succeeded) {
                            
                            if (_delegateSet) {
                                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                                    if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterUserSuccessed:token:)]) {
                                        [delegate userManagerRegisterUserSuccessed:user token:token];
                                    }
                                }
                                return;
                            }
                        }
                    }];
                }
            }];
        }
        if (error && _delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerRegisterUserFailure:)]) {
                    [delegate userManagerRegisterUserFailure:[self registerError:error]];
                }
            }
        }
    }];
    
    
}


//返回错误解析
- (YCUserManagerRegisterError)registerError:(NSError *)error {
    
    NSString *errorString = error.userInfo[@"error"];
    if ([errorString isEqualToString:@"Username has already been taken"]) {
        return YCUserManagerRegisterErrorHasSameUserName;
    } else if ([errorString isEqualToString:@"此电子邮箱已经被占用。"]) {
        return YCUserManagerRegisterErrorHasSameEmail;
    } else if ([errorString isEqualToString:@"The email address was invalid."]) {
        return YCUserManagerRegisterErrorUserEmailIsNotvalid;
    } else {
        return YCUserManagerRegisterErrorNetworkingFailure;
    }
    
    return 0;
}

- (void)setUserNickName:(NSString *)nickName {
    
    [[AVUser currentUser] setObject:nickName forKey:@"nickName"];
    [[AVUser currentUser] saveInBackground];
}

#pragma mark
//_______________用户登录______________
- (void)logInWithUserName:(NSString *)userName password:(NSString *)password {
    
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerLogInWillLoginWithUserNameAndPassword)]) {
                [delegate userManagerLogInWillLoginWithUserNameAndPassword];
            }
        }
    }
    
    [AVUser logInWithUsernameInBackground:userName password:password block:^(AVUser *user, NSError *error) {
        if (user) {
            //成功
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithUserNameAndPasswordSuccessed:)]) {
                        [delegate userManagerLogInLoginWithUserNameAndPasswordSuccessed:user];
                    }
                }
            }
        } else {
            //失败
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithUserNameAndPasswordFaliure)]) {
                        [delegate userManagerLogInLoginWithUserNameAndPasswordFaliure];
                    }
                }
            }
        }
    }];
}

//登陆并反回token
- (void)logInReturnTokenWithUserName:(NSString *)userName password:(NSString *)password {
    
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerLogInWillLoginWithUserNameAndPassword)]) {
                [delegate userManagerLogInWillLoginWithUserNameAndPassword];
            }
        }
    }
    
    [AVUser logInWithUsernameInBackground:userName password:password block:^(AVUser *user, NSError *error) {
        NSLog(@"---------%@",error);
        if (user) {
            //成功
            
            NSString *token = user[@"token"];
            
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithUserNameAndPasswordSuccessed:token:)]) {
                        [delegate userManagerLogInLoginWithUserNameAndPasswordSuccessed:user token:token];
                    }
                }
            }
        } else {
            //失败
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithUserNameAndPasswordFaliure)]) {
                        [delegate userManagerLogInLoginWithUserNameAndPasswordFaliure];
                    }
                }
            }
        }
    }];
}


//使用缓存用户登录
- (BOOL)logInWithCurrentUser {
    AVUser *currentUser = [AVUser currentUser];
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerLogInWillLoginWithCurrentUser)]) {
                [delegate userManagerLogInWillLoginWithCurrentUser];
            }
        }
    }
    if (currentUser) {
        //成功
        if (_delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithCurrentUserSccessed:)]) {
                    [delegate userManagerLogInLoginWithCurrentUserSccessed:currentUser];
                }
            }
        }
        return YES;
    } else {
        //失败
        if (_delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithCurrentUserFaliure)]) {
                    [delegate userManagerLogInLoginWithCurrentUserFaliure];
                }
            }
        }
        
        return NO;
    }
}
//缓存用户登录并且返回token
- (BOOL)logInWithCurrentUserAndReturnToken {
    AVUser *currentUser = [AVUser currentUser];
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerLogInWillLoginWithCurrentUser)]) {
                [delegate userManagerLogInWillLoginWithCurrentUser];
            }
        }
    }
    if (currentUser) {
        //成功
        NSString *token = currentUser[@"token"];
        if (_delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithCurrentUserSccessed:token:)]) {
                    [delegate userManagerLogInLoginWithCurrentUserSccessed:currentUser token:token];
                }
            }
        }
        return YES;
    } else {
        //失败
        if (_delegateSet) {
            for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                if (delegate && [delegate respondsToSelector:@selector(userManagerLogInLoginWithCurrentUserFaliure)]) {
                    [delegate userManagerLogInLoginWithCurrentUserFaliure];
                }
            }
        }
        
        return NO;
    }
}

// _______________修改密码____________
- (void)resetUserPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword {
    
    if (_delegateSet) {
        for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
            if (delegate && [delegate respondsToSelector:@selector(userManagerWillResetUserPassword)]) {
                [delegate userManagerWillResetUserPassword];
            }
        }
    }
    
    [[AVUser currentUser] updatePassword:oldPassword newPassword:newPassword block:^(id object, NSError *error) {
        if (error) {
            
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerResetUserPasswordFaliure)]) {
                        [delegate userManagerResetUserPasswordFaliure];
                    }
                }
            }
            
            
        } else {
            
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(userManagerResetUserPasswordSuccessed)]) {
                        [delegate userManagerResetUserPasswordSuccessed];
                    }
                }
            }
            
        }
    }];
}

- (void)resetUserPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword stateBlock:(void (^)(BOOL))handle {
    
    [[AVUser currentUser] updatePassword:oldPassword newPassword:newPassword block:^(id object, NSError *error) {
        NSLog(@"%@",error);
        if (error) {
            
            handle(NO);
            
            
        } else {
            
            handle(YES);
            
        }
    }];

}

- (void)findPasswordByEmail:(NSString *)email {
    [AVUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(usermanagerDidSendEmail)]) {
                        [delegate usermanagerDidSendEmail];
                    }
                }
            }
        } else {
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(usermanagerSendEmailFailure)]) {
                        [delegate usermanagerSendEmailFailure];
                    }
                }
            }
        }
        
    }];
}

//——————————————————邮箱验证——————————————————
- (void)sendEmailForVerify:(NSString *)email {
    
    [AVUser requestEmailVerify:email withBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            //发送成功
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(usermanagerDidSendEmail)]) {
                        [delegate usermanagerDidSendEmail];
                    }
                }
            }
        } else {
            //发送失败
            if (_delegateSet) {
                for (id<YCUserManagerDelegate> delegate in [self.delegateSet allObjects]) {
                    if (delegate && [delegate respondsToSelector:@selector(usermanagerSendEmailFailure)]) {
                        [delegate usermanagerSendEmailFailure];
                    }
                }
            }
        }
        
    }];
}
//登出


- (void)getRongCloudTokenWithUserId:(NSString *)userId UserNickName:(NSString *)userNickName tokenHandle:(void (^)(NSString *))handel {
    
    NSString *URLString = [NSString stringWithFormat:CARED_GET_RONGCLOUD_TOKEN_URL,userId,userNickName];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!data) {
            
            handel(@"错误");
            
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSString *token = dict[@"token"];
        handel(token);
    }];
    
    [task resume];
}


- (void)logOut {
    [AVUser logOut];
}


#pragma mark - 用户位置
- (void)setUserLocation:(userLocationModel *)locationModel {
    
//    NSString *city = locationModel.city;
//    NSString *area = locationModel.area;
//    NSNumber *longtitude = locationModel.longtitudeNumber;
//    NSNumber *latitude   = locationModel.latitudeNumber;
    AVUser *currentUser = [AVUser currentUser];
    NSDictionary *locationDic = @{
                                  CareD_Lake_UserLocationModel_Key_Area:locationModel.area,
                                  CareD_Lake_UserLocationModel_Key_City:locationModel.city,
                                  CareD_Lake_UserLocationModel_Key_Latitude:locationModel.latitudeNumber,
                                  CareD_Lake_UserLocationModel_Key_Longtitude:locationModel.longtitudeNumber
                                  
                                  
                                  };
    [currentUser setObject:locationDic forKey:CARED_LEANCLOUD_USER_location];
    [currentUser saveInBackground];
    
}
- (userLocationModel *)getLocationByUser:(AVUser *)user {
    
    NSDictionary *locationDic = user[CARED_LEANCLOUD_USER_location];
    
    NSNumber *longtitudeN = locationDic[CareD_Lake_UserLocationModel_Key_Longtitude];
    NSNumber *latitudeN = locationDic[CareD_Lake_UserLocationModel_Key_Latitude];
    
    userLocationModel *location = [[userLocationModel alloc] initWithUserLongtitude:[longtitudeN doubleValue] latitude:[latitudeN doubleValue] city:locationDic[CareD_Lake_UserLocationModel_Key_City] area:locationDic[CareD_Lake_UserLocationModel_Key_Area]];
    
    return location;
}






///代理对象集合懒加载
- (NSMutableSet *)delegateSet{
    if (!_delegateSet) {
        _delegateSet = [NSMutableSet set];
    }
    return _delegateSet;
}


///加密
- (NSString *)stringByEncryptionFromString:(NSString *)string {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:string.length];
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:(NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [array addObject:substring];
    }];
    
    NSMutableString *resultString = [NSMutableString string];
    for (NSString *str in array) {
        if ([str isEqualToString:@"a"]) {
            [resultString appendString:@"c1"];
        } else
            if ([str isEqualToString:@"b"]) {
                [resultString appendString:@"d3"];
            } else
                if ([str isEqualToString:@"c"]) {
                    [resultString appendString:@"e5"];
                } else
                    if ([str isEqualToString:@"d"]) {
                        [resultString appendString:@"f7"];
                    } else
                        if ([str isEqualToString:@"e"]) {
                            [resultString appendString:@"g9"];
                        } else
                            if ([str isEqualToString:@"f"]) {
                                [resultString appendString:@"h2"];
                            } else
                                if ([str isEqualToString:@"g"]) {
                                    [resultString appendString:@"i4"];
                                } else
                                    if ([str isEqualToString:@"h"]) {
                                        [resultString appendString:@"j6"];
                                    } else
                                        if ([str isEqualToString:@"i"]) {
                                            [resultString appendString:@"k8"];
                                        } else
                                            if ([str isEqualToString:@"j"]) {
                                                [resultString appendString:@"l0"];
                                            } else
                                                if ([str isEqualToString:@"k"]) {
                                                    [resultString appendString:@"m1"];
                                                } else
                                                    if ([str isEqualToString:@"l"]) {
                                                        [resultString appendString:@"n3"];
                                                    } else
                                                        if ([str isEqualToString:@"m"]) {
                                                            [resultString appendString:@"o5"];
                                                        } else
                                                            if ([str isEqualToString:@"n"]) {
                                                                [resultString appendString:@"p7"];
                                                            } else
                                                                if ([str isEqualToString:@"o"]) {
                                                                    [resultString appendString:@"q9"];
                                                                } else
                                                                    if ([str isEqualToString:@"p"]) {
                                                                        [resultString appendString:@"r2"];
                                                                    } else
                                                                        if ([str isEqualToString:@"q"]) {
                                                                            [resultString appendString:@"s4"];
                                                                        } else
                                                                            if ([str isEqualToString:@"r"]) {
                                                                                [resultString appendString:@"t6"];
                                                                            } else
                                                                                if ([str isEqualToString:@"s"]) {
                                                                                    [resultString appendString:@"u8"];
                                                                                } else
                                                                                    if ([str isEqualToString:@"t"]) {
                                                                                        [resultString appendString:@"v0"];
                                                                                    } else
                                                                                        if ([str isEqualToString:@"u"]) {
                                                                                            [resultString appendString:@"w1"];
                                                                                        } else
                                                                                            if ([str isEqualToString:@"v"]) {
                                                                                                [resultString appendString:@"x3"];
                                                                                            } else
                                                                                                if ([str isEqualToString:@"w"]) {
                                                                                                    [resultString appendString:@"y5"];
                                                                                                } else
                                                                                                    if ([str isEqualToString:@"x"]) {
                                                                                                        [resultString appendString:@"z7"];
                                                                                                    } else
                                                                                                        if ([str isEqualToString:@"y"]) {
                                                                                                            [resultString appendString:@"a9"];
                                                                                                        } else
                                                                                                            if ([str isEqualToString:@"z"]) {
                                                                                                                [resultString appendString:@"b2"];
                                                                                                            } else
                                                                                                                if ([str isEqualToString:@"A"]) {
                                                                                                                    [resultString appendString:@"ab"];
                                                                                                                } else
                                                                                                                    if ([str isEqualToString:@"B"]) {
                                                                                                                        [resultString appendString:@"bc"];
                                                                                                                    } else
                                                                                                                        if ([str isEqualToString:@"C"]) {
                                                                                                                            [resultString appendString:@"cd"];
                                                                                                                        } else
                                                                                                                            if ([str isEqualToString:@"D"]) {
                                                                                                                                [resultString appendString:@"de"];
                                                                                                                            } else
                                                                                                                                if ([str isEqualToString:@"E"]) {
                                                                                                                                    [resultString appendString:@"ef"];
                                                                                                                                } else
                                                                                                                                    if ([str isEqualToString:@"F"]) {
                                                                                                                                        [resultString appendString:@"fg"];
                                                                                                                                    } else
                                                                                                                                        if ([str isEqualToString:@"G"]) {
                                                                                                                                            [resultString appendString:@"gh"];
                                                                                                                                        } else
                                                                                                                                            if ([str isEqualToString:@"H"]) {
                                                                                                                                                [resultString appendString:@"hi"];
                                                                                                                                            } else
                                                                                                                                                if ([str isEqualToString:@"I"]) {
                                                                                                                                                    [resultString appendString:@"ij"];
                                                                                                                                                } else
                                                                                                                                                    if ([str isEqualToString:@"J"]) {
                                                                                                                                                        [resultString appendString:@"jk"];
                                                                                                                                                    } else
                                                                                                                                                        if ([str isEqualToString:@"K"]) {
                                                                                                                                                            [resultString appendString:@"kl"];
                                                                                                                                                        } else
                                                                                                                                                            if ([str isEqualToString:@"L"]) {
                                                                                                                                                                [resultString appendString:@"lm"];
                                                                                                                                                            } else
                                                                                                                                                                if ([str isEqualToString:@"M"]) {
                                                                                                                                                                    [resultString appendString:@"mn"];
                                                                                                                                                                } else
                                                                                                                                                                    if ([str isEqualToString:@"N"]) {
                                                                                                                                                                        [resultString appendString:@"no"];
                                                                                                                                                                    } else
                                                                                                                                                                        if ([str isEqualToString:@"O"]) {
                                                                                                                                                                            [resultString appendString:@"op"];
                                                                                                                                                                        } else
                                                                                                                                                                            if ([str isEqualToString:@"P"]) {
                                                                                                                                                                                [resultString appendString:@"pq"];
                                                                                                                                                                            } else
                                                                                                                                                                                if ([str isEqualToString:@"Q"]) {
                                                                                                                                                                                    [resultString appendString:@"qr"];
                                                                                                                                                                                } else
                                                                                                                                                                                    if ([str isEqualToString:@"R"]) {
                                                                                                                                                                                        [resultString appendString:@"rs"];
                                                                                                                                                                                    } else
                                                                                                                                                                                        if ([str isEqualToString:@"S"]) {
                                                                                                                                                                                            [resultString appendString:@"st"];
                                                                                                                                                                                        } else
                                                                                                                                                                                            if ([str isEqualToString:@"T"]) {
                                                                                                                                                                                                [resultString appendString:@"tu"];
                                                                                                                                                                                            } else
                                                                                                                                                                                                if ([str isEqualToString:@"U"]) {
                                                                                                                                                                                                    [resultString appendString:@"uv"];
                                                                                                                                                                                                } else
                                                                                                                                                                                                    if ([str isEqualToString:@"V"]) {
                                                                                                                                                                                                        [resultString appendString:@"vw"];
                                                                                                                                                                                                    } else
                                                                                                                                                                                                        if ([str isEqualToString:@"W"]) {
                                                                                                                                                                                                            [resultString appendString:@"wx"];
                                                                                                                                                                                                        } else
                                                                                                                                                                                                            if ([str isEqualToString:@"X"]) {
                                                                                                                                                                                                                [resultString appendString:@"xy"];
                                                                                                                                                                                                            } else
                                                                                                                                                                                                                if ([str isEqualToString:@"Y"]) {
                                                                                                                                                                                                                    [resultString appendString:@"yz"];
                                                                                                                                                                                                                } else
                                                                                                                                                                                                                    if ([str isEqualToString:@"Z"]) {
                                                                                                                                                                                                                        [resultString appendString:@"za"];
                                                                                                                                                                                                                    } else
                                                                                                                                                                                                                        if ([str isEqualToString:@"@"]) {
                                                                                                                                                                                                                            [resultString appendString:@"a"];
                                                                                                                                                                                                                        } else
                                                                                                                                                                                                                            if ([str isEqualToString:@"."]) {
                                                                                                                                                                                                                                [resultString appendString:@"d"];
                                                                                                                                                                                                                            } else
                                                                                                                                                                                                                                if ([str isEqualToString:@"1"]) {
                                                                                                                                                                                                                                    [resultString appendString:@"A"];
                                                                                                                                                                                                                                } else
                                                                                                                                                                                                                                    if ([str isEqualToString:@"2"]) {
                                                                                                                                                                                                                                        [resultString appendString:@"b"];
                                                                                                                                                                                                                                    } else
                                                                                                                                                                                                                                        if ([str isEqualToString:@"3"]) {
                                                                                                                                                                                                                                            [resultString appendString:@"C"];
                                                                                                                                                                                                                                        } else
                                                                                                                                                                                                                                            if ([str isEqualToString:@"4"]) {
                                                                                                                                                                                                                                                [resultString appendString:@"d"];
                                                                                                                                                                                                                                            } else
                                                                                                                                                                                                                                                if ([str isEqualToString:@"5"]) {
                                                                                                                                                                                                                                                    [resultString appendString:@"E"];
                                                                                                                                                                                                                                                } else
                                                                                                                                                                                                                                                    if ([str isEqualToString:@"6"]) {
                                                                                                                                                                                                                                                        [resultString appendString:@"f"];
                                                                                                                                                                                                                                                    } else
                                                                                                                                                                                                                                                        if ([str isEqualToString:@"7"]) {
                                                                                                                                                                                                                                                            [resultString appendString:@"G"];
                                                                                                                                                                                                                                                        } else
                                                                                                                                                                                                                                                            if ([str isEqualToString:@"8"]) {
                                                                                                                                                                                                                                                                [resultString appendString:@"h"];
                                                                                                                                                                                                                                                            } else
                                                                                                                                                                                                                                                                if ([str isEqualToString:@"9"]) {
                                                                                                                                                                                                                                                                    [resultString appendString:@"I"];
                                                                                                                                                                                                                                                                } else
                                                                                                                                                                                                                                                                    if ([str isEqualToString:@"0"]) {
                                                                                                                                                                                                                                                                        [resultString appendString:@"g"];
                                                                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                                                                        [resultString appendString:str];
                                                                                                                                                                                                                                                                    }
    }
    
    
    return resultString;
}

@end
