//
//  userLocationModel.m
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "userLocationModel.h"

@implementation userLocationModel

//- (instancetype)initWithUserLocationDictionary:(NSDictionary *)userLocationDictionary {
//    if (self = [super init]) {
//
//        NSString *city = userLocationDictionary[CareD_Lake_UserLocationModel_Key_City];
//        NSString *area = userLocationDictionary[CareD_Lake_UserLocationModel_Key_Area];
//        NSNumber *longtitude = userLocationDictionary[CareD_Lake_UserLocationModel_Key_Longtitude];
//        NSNumber *latitude   = userLocationDictionary[CareD_Lake_UserLocationModel_Key_Latitude];
//
//        _longtitudeNumber = longtitude;
//        _latitudeNumber = latitude;
//
//        _city = city;
//        _area = area;
//        _longtitude = [longtitude doubleValue];
//        _latitude  = [latitude   doubleValue];
//
//
//
//    }
//    return self;
//}

- (instancetype)initWithUserLongtitude:(CGFloat)longtitude latitude:(CGFloat)latitude city:(NSString *)city area:(NSString *)area {
    if (self = [super init]) {
        _city = city;
        _area = area;
        
        _longtitude = longtitude;
        _latitude = latitude;
        
        _longtitudeNumber = [NSNumber numberWithDouble:longtitude];
        _latitudeNumber = [NSNumber numberWithDouble:latitude];
        
    }
    return self;
}

@end
