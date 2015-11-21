//
//  Realtime.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realtime_weather.h"
#import "Wind.h"

@interface Realtime : NSObject

/*
 "city_code": "101010100",
 "city_name": "北京",
 "date": "2015-11-10",
 "time": "15:00:00",
 "week": 2,
 "moon": "九月廿九",
 "dataUptime": 1447141407,
 "weather": {},
 "wind": {}
 */

@property (nonatomic, copy) NSString *city_code;//城市编码
@property (nonatomic, copy) NSString *city_name;//城市名
@property (nonatomic, copy) NSString *date;//日期
@property (nonatomic, copy) NSString *time;//时间
@property (nonatomic, strong) NSNumber *week ;//星期*
@property (nonatomic, copy) NSString *moon;//农历日期
@property (nonatomic, copy) NSString *dataUptime;//更新时间
@property (nonatomic, strong) NSDictionary *weather;//天气
@property (nonatomic, strong) NSDictionary *wind;//风

@end
