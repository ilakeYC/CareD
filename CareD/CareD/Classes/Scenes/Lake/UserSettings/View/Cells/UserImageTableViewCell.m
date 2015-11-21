//
//  UserImageTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserImageTableViewCell.h"

@interface UserImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;


@end

@implementation UserImageTableViewCell

- (void)setUser:(AVUser *)user {
    _user = user;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height / 2;
    
    [[YCUserImageManager sharedUserImage] getImageWithUser:user handel:^(UIImage *image) {
       
        self.userImageView.image = image;
        
    }];
    
}

- (void)showImage:(void(^)(void))handle {
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.userImageView.alpha = 1;
        self.progressView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [[YCUserImageManager sharedUserImage] getImageWithUser:self.user handel:^(UIImage *image) {
            
            self.userImageView.image = image;
            
            handle();
            
        }];
    }];
    
}
- (void)hiddenImage {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.userImageView.alpha = 0;
        self.progressView.alpha = 1;
        
    }];
    
}

- (void)awakeFromNib {
    self.progressView.progress = 0;
    self.progressView.alpha = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
