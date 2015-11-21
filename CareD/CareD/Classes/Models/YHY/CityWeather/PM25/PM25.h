//
//  PM25.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PM25_pm25.h"

@interface PM25 : NSObject

/*
 "key": "Haerbin",
 "show_desc": 0,
 "pm25": {},
 "dateTime": "2015年11月10日16时",
 "cityName": "哈尔滨"
*/

@property (nonatomic, copy) NSString *key;//
@property (nonatomic, copy) NSString *show_desc;
@property (nonatomic, strong) NSDictionary *pm25;//
@property (nonatomic, copy) NSString *dateTime;//时间
@property (nonatomic, copy) NSString *cityName;//城市名




@end
