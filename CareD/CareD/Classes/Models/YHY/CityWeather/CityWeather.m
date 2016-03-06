//
//  CityWeather.m
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "CityWeather.h"

@implementation CityWeather

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"\n%d,\n%s\n",__LINE__,__FUNCTION__);
    NSLog(@"CityWeather KVC error: key:%@ 没有找到", key);
}



@end
