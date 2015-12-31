//
//  YHYWeatherManger.h
//  CareD
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserWeather.h"
#import "CityWeather.h"
#import "Realtime.h"
#import "Realtime_weather.h"
#import "Life.h"
#import "Life_info.h"
#import "PM25.h"
#import "PM25_pm25.h"



@interface YHYWeatherManger : NSObject

@property (nonatomic,strong) UserWeather *currentUserWeather;

+ (instancetype)sharedYHYWeatherManager;

///请求天气
- (void)requestWeatherByCityName:(NSString *)cityName
                            area:(NSString *)area
                           block:(void(^)(UserWeather *model))handle;






@end
