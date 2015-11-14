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






@end

@implementation CircleListCell

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
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pica.nipic.com/2007-11-03/200711315506368_2.jpg"]];
}

@end
