//
//  HYWeatherTableViewCell.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYWeatherTableViewCell.h"

//#import "HYWeatherManager.h"


@interface HYWeatherTableViewCell ()
//阴影
@property (weak, nonatomic) IBOutlet UIView *shadowView;
//城市
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
//星期*
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
//空气质量
@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;
//天气
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
//温度
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
//天气图片
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
//运动提示
@property (weak, nonatomic) IBOutlet UILabel *reminderLable;

//pm2.5(空气质量)
@property (weak, nonatomic) IBOutlet UILabel *kongqizhiliangLabel;

@end

@implementation HYWeatherTableViewCell

- (void)setUserWeather:(UserWeather *)userWeather
{
    self.temperatureLabel.text = [userWeather.temp stringByAppendingString:@"℃"];
    self.qualityLabel.text = userWeather.air;
    self.reminderLable.text = userWeather.life;
    self.weatherLabel.text = userWeather.weather;
    self.cityLable.text = [userWeather.city stringByAppendingString:@"市"];
    
    if ([userWeather.weather isEqualToString:@"阴天"] || [userWeather.weather isEqualToString:@"阴"]) {
        self.weatherImageView.image = [UIImage imageNamed:@"Cloudy"];
    }else if ([userWeather.weather isEqualToString:@"多云"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Cloudy_small"];
    }else if ([userWeather.weather isEqualToString:@"雾"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Fog"];
    }else if ([userWeather.weather isEqualToString:@"大雨"] || [userWeather.weather isEqualToString:@"阵雨"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Rain_big"];
    }else if ([userWeather.weather isEqualToString:@"小雨"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Rain_small"];
    }else if ([userWeather.weather isEqualToString:@"雪"] || [userWeather.weather containsString:@"雪"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Snow"];
    }else if ([userWeather.weather isEqualToString:@"晴"]){
        self.weatherImageView.image = [UIImage imageNamed:@"Sunny"];
    }else if ([userWeather.weather isEqualToString:@"霾"]){
        self.weatherImageView.image = [UIImage imageNamed:@"mai"];
    }else if ([userWeather.weather containsString:@"雹"]) {
        self.weatherImageView.image = [UIImage imageNamed:@"yujiabingbao"];
    } else if ([userWeather.weather isEqualToString:@"雨夹雪"]) {
        self.weatherImageView.image = [UIImage imageNamed:@"yujiaxue"];
    } else if ([userWeather.weather isEqualToString:@"雷阵雨"]) {
        self.weatherImageView.image = [UIImage imageNamed:@"leizhenyu"];
    }else{
        self.weatherImageView.image = [UIImage imageNamed:@"Sunny"];
    }
}


- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.shadowView.layer.shadowOpacity = 0.6;
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日,EEEE"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSArray *array = [dateString componentsSeparatedByString:@","];
    self.dateLable.text = array[0];
    self.weekLabel.text = array[1];
    
}



@end
