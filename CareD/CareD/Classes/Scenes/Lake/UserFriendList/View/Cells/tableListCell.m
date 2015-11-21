//
//  tableListCell.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "tableListCell.h"

@interface tableListCell ()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation tableListCell

- (void)setUser:(AVUser *)user {
    _user = user;
    self.mainTitleLabel.text = user[@"nickName"];
    self.mainImageView.image = [UIImage imageNamed:@"Icon-512"];
    self.mainImageView.layer.cornerRadius = self.mainImageView.frame.size.height / 2;
    
    [[YCUserImageManager sharedUserImage] getImageWithUser:user handel:^(UIImage *image) {
       
        
        self.mainImageView.image = image;
        
    }];
    
    
    userLocationModel *location = [[YCUserManager sharedUserManager] getLocationByUser:user];
    CGFloat distance = [[HYLocationManager sharedHYLocationManager] distanceBetweenOrderByOtherLatitude:location.latitude  longitude:location.longtitude];
    
    if (distance < 1000) {
        
        self.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f米",distance];
    } else if(distance >= 1000) {
        
        self.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f公里",distance / 1000];
        
    }

    
    
    self.userLocationLabel.text = [NSString stringWithFormat:@"%@,%@",location.city,location.area];
}

- (void)awakeFromNib {
    
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.shadowView.layer.shadowOpacity = 0.7;
    
    self.mainContentView.layer.cornerRadius = 10;
    self.mainContentView.layer.masksToBounds = YES;
    
    self.mainImageView.layer.cornerRadius = 5;
    self.mainImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
