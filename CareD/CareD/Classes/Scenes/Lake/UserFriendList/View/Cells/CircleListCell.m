//
//  CircleListCell.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "CircleListCell.h"

@interface CircleListCell ()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UIView *imageViewContentView;

@property (weak, nonatomic) IBOutlet UIView *labelsContentView;
@property (weak, nonatomic) IBOutlet UIView *paperImageMasksView;




@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAirLabel;


@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;




@end

@implementation CircleListCell

- (void)setUser:(AVUser *)user {
    _user = user;
    self.userNickNameLabel.text = user[@"nickName"];
    userLocationModel *locationModel = [[YCUserManager sharedUserManager] getLocationByUser:user];
    [[YHYWeatherManger sharedYHYWeatherManager] requestWeatherByCityName:locationModel.city area:locationModel.area block:^(UserWeather *model) {
       
        self.userLocationLabel.text = [NSString stringWithFormat:@"%@,%@",locationModel.city,locationModel.area];
        self.userWeatherLabel.text = [NSString stringWithFormat:@"天气：%@",model.weather];
        self.userAirLabel.text = [NSString stringWithFormat:@"空气质量：%@",model.air];
        if ([model.air isEqualToString:@"重度污染"]) {
            self.userAirLabel.textColor = CareD_Lake_COLOR_WorningRed;
        } else if ([model.air isEqualToString:@"轻度污染"]) {
            self.userAirLabel.textColor = [UIColor brownColor];
        }
        self.userTempLabel.text = [NSString stringWithFormat:@"温度：%@℃",model.temp];
        
    }];
    
    [[YCUserImageManager sharedUserImage] getImageUrlWithUser:user handel:^(NSString *URL) {
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:[UIImage imageNamed:@"Icon-512"]];
    }];
    
    CGFloat distance = [[HYLocationManager sharedHYLocationManager] distanceBetweenOrderByOtherLatitude:locationModel.latitude  longitude:locationModel.longtitude];
    
    if (distance < 1000) {
        
        self.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f米",distance];
    } else if(distance >= 1000) {
        
        self.distanceLabel.text = [NSString stringWithFormat:@"大约相距:%.2f公里",distance / 1000];
        
    }
    
    
}

- (void)awakeFromNib {
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, -2);
    self.shadowView.layer.shadowOpacity = 0.7;
    
    self.mainContentView.layer.cornerRadius = 10;
    self.mainContentView.layer.masksToBounds = YES;
    self.imageViewContentView.layer.masksToBounds = YES;
    self.labelsContentView.layer.shadowOpacity = 0.7;
    self.labelsContentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.labelsContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.paperImageMasksView.layer.masksToBounds = YES;
    
    
}

@end
