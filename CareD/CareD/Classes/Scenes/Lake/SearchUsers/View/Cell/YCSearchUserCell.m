//
//  YCSearchUserCell.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YCSearchUserCell.h"

@interface YCSearchUserCell ()
{
    AVUser *cellUser;
}
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@property (weak, nonatomic) IBOutlet UIView *imageMasksView;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation YCSearchUserCell


- (void)setUser:(AVUser *)user {
    cellUser = user;
    NSString *nickName = user[@"nickName"];
    self.nickNameLabel.text = nickName;
    self.mainImageView.image = [UIImage imageNamed:@"Icon-512"];
    [[YCUserImageManager sharedUserImage] getImageWithUser:user handel:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        self.mainImageView.image = image;
            NSLog(@"%@",image);
        });
    }];
}

- (UIImage *)image {
    return self.imageView.image;
}
- (AVUser *)user {
    return cellUser;
}

- (void)awakeFromNib {
    self.mainContentView.layer.cornerRadius = 6;
    self.imageMasksView.layer.cornerRadius = 5;
    self.imageMasksView.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
