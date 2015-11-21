//
//  Realtime_weather.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Realtime_weather : NSObject

/*
 "temperature": "6",
 "humidity": "89",
 "info": "多云",
 "img": "1"
*/

@property (nonatomic, copy) NSString *temperature;//温度
@property (nonatomic, copy) NSString *humidity;//湿度
@property (nonatomic, copy) NSString *info;//天气信息
@property (nonatomic, copy) NSString *img;//


@end
