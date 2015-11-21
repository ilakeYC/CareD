//
//  UserImageTableViewCell.h
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserImageTableViewCell : UITableViewCell

@property (nonatomic,strong) AVUser *user;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

- (void)showImage:(void(^)(void))handle;
- (void)hiddenImage;

@end
