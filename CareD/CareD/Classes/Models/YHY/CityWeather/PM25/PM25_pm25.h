//
//  PM25_pm25.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PM25_pm25 : NSObject

/*
 "curPm": "155",
 "pm25": "117",
 "pm10": "71",
 "level": 4,
 "quality": "中度污染",
 "des": "对污染物比较敏感的人群，例如儿童和老年人、呼吸道疾病或心脏病患者，以及喜爱户外活动的人，他们的健康状况会受到影响，但对健康人群基本没有影响。"
*/

@property (nonatomic, copy) NSString *curPm;
@property (nonatomic, copy) NSString *pm25;
@property (nonatomic, copy) NSString *pm10;
@property (nonatomic, copy) NSString *level;//水平面
@property (nonatomic, copy) NSString *quality;//质量
@property (nonatomic, copy) NSString *des;//描述


@end
