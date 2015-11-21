//
//  YHYWeatherManger.m
//  CareD
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "YHYWeatherManger.h"

@implementation YHYWeatherManger

+ (instancetype)sharedYHYWeatherManager
{
    static YHYWeatherManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [YHYWeatherManger new];
    });
    return manager;
}

- (void)requestWeatherByCityName:(NSString *)cityName area:(NSString *)area block:(void (^)(UserWeather *))handle
{
    NSString *str = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *urlStr = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/weather/query?cityname=%@&key=c37efe22ee2d29e939ac5aa364f7011b",str];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (!data || data.bytes == 0) {
                return ;
            }
            
            UserWeather *userWeather1 = [self returnWeatherBy:data];
            if (!userWeather1) {
                return;
            }
            userWeather1.area = area;
            NSDictionary *weatherDic = @{
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Air_KEY:userWeather1.air,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Area_KEY:area,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_City_KEY:userWeather1.city,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Life_KEY:userWeather1.life,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Temp_KEY:userWeather1.temp,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_TempWeather_KEY:userWeather1.tempWeather,
                                         CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Weather_KEY:userWeather1.weather
                                         };
            
            [[NSUserDefaults standardUserDefaults] setObject:weatherDic forKey:CareD_Lake_UserDefaults_CurrentUserWeather_Key];
            
            handle(userWeather1);
        });
        
    }];
    //开始加载数据
    [task resume];
    
}

- (UserWeather *)returnWeatherBy:(NSData *)data
{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([dictionary[@"reason"] isEqualToString:@"查询不到该城市的信息"]) {
        return nil;
    }
    NSDictionary *dict = dictionary[@"result"];
    
    NSDictionary *dic = dict[@"data"];
    
    
    UserWeather *userWeather = [UserWeather new];
    
    CityWeather *cityWeather = [CityWeather new];
    [cityWeather setValuesForKeysWithDictionary:dic];
    
    //实时天气
    NSDictionary *realtimeDic = cityWeather.realtime;
    Realtime *realtime = [Realtime new];
    [realtime setValuesForKeysWithDictionary:realtimeDic];
    userWeather.city = realtime.city_name;
    //实时天气(weather)
    NSDictionary *realtime_weatherDic = realtime.weather;
    Realtime_weather *realtime_weather = [Realtime_weather new];
    [realtime_weather setValuesForKeysWithDictionary:realtime_weatherDic];
    
    
    userWeather.temp = realtime_weather.temperature;
    userWeather.weather = realtime_weather.info;
    
    NSString *str = [userWeather.temp stringByAppendingString:@"℃/"];
    userWeather.tempWeather = [str stringByAppendingString:userWeather.weather];
    
    //生活指数
    NSDictionary *lifeDic = cityWeather.life;
    Life *life = [Life new];
    [life setValuesForKeysWithDictionary:lifeDic];
    //生活指数（info）
    NSDictionary *life_infoDic = life.info;
    for (int i = 0; i < life_infoDic.count; i++) {
        Life_info *life_info = [Life_info new];
        [life_info setValuesForKeysWithDictionary:life_infoDic];
        userWeather.life = life_info.yundong[1];
    }
    
    //未来几天天气预报
    NSArray *array = cityWeather.weather;
    for (NSDictionary *dict in array) {
        Weather *weather = [Weather new];
        [weather setValuesForKeysWithDictionary:dict];
    }
    
    //空气质量指数
    NSDictionary *PM25Dic = cityWeather.pm25;
    PM25 *pm25 = [PM25 new];
    [pm25 setValuesForKeysWithDictionary:PM25Dic];
    //空气质量指数（pm25）
    NSDictionary *PM25_pm25Dic = pm25.pm25;
    PM25_pm25 *PM_pm25 = [PM25_pm25 new];
    [PM_pm25 setValuesForKeysWithDictionary:PM25_pm25Dic];
    userWeather.air = PM_pm25.quality;
    
    NSLog(@"解析完成...");
    
    return userWeather;
}

- (UserWeather *)currentUserWeather {
    
//    @property (nonatomic, copy) NSString *temp;
//    @property (nonatomic, copy) NSString *weather;
//    @property (nonatomic, copy) NSString *tempWeather;
//    @property (nonatomic, copy) NSString *air;
//    @property (nonatomic, copy) NSString *life;
//    @property (nonatomic, copy) NSString *city;
//    @property (nonatomic, copy) NSString *area;
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:CareD_Lake_UserDefaults_CurrentUserWeather_Key];
    UserWeather *model = [UserWeather new];
    
    model.temp = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Temp_KEY];
    model.weather = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Weather_KEY];
    model.tempWeather = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_TempWeather_KEY];
    model.air = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Air_KEY];
    model.life = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Life_KEY];
    model.city = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_City_KEY];
    model.area = dic[CareD_Lake_UserDefaults_CurrentUserWeather_DIC_Area_KEY];
    
    return model;
}

@end
