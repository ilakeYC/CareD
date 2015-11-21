//
//  CityWeather.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realtime.h"
#import "Life.h"
#import "Weather.h"
#import "PM25.h"

@interface CityWeather : NSObject

@property (nonatomic, strong) NSDictionary *realtime;//实时天气
@property (nonatomic, strong) NSDictionary *life;//生活指数
@property (nonatomic, strong) NSArray *weather;//未来几天天气预报
@property (nonatomic, strong) NSDictionary *pm25;//空气质量指数

/*** 暂无数据 ***/
@property (nonatomic, copy) NSString *jingqu;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSNumber *isForeign;

@end
