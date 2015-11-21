//
//  userLocationModel.h
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userLocationModel : NSObject

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
///经度
@property (nonatomic,assign) CGFloat longtitude;
///纬度
@property (nonatomic,assign) CGFloat latitude;


@property (nonatomic,strong) NSNumber *longtitudeNumber;
@property (nonatomic,strong) NSNumber *latitudeNumber;

//- (instancetype)initWithUserLocationDictionary:(NSDictionary *)userLocationDictionary;

- (instancetype)initWithUserLongtitude:(CGFloat)longtitude
                              latitude:(CGFloat)latitude
                                  city:(NSString *)city
                                  area:(NSString *)area;

@end
