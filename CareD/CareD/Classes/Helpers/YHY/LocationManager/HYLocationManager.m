//
//  HYLocationManager.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface HYLocationManager () <CLLocationManagerDelegate>
{
    CLLocationManager *_manager;
}

//经度
@property (nonatomic, assign) CGFloat longitude;
//纬度
@property (nonatomic, assign) CGFloat latitude;
//城市
@property (nonatomic, strong) NSString *city;
//区
@property (nonatomic, strong) NSString *area;

@end

@implementation HYLocationManager

+ (instancetype)sharedHYLocationManager
{
    static HYLocationManager *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        locationManager = [[HYLocationManager alloc] init];
        
        [NSTimer scheduledTimerWithTimeInterval:600 target:locationManager selector:@selector(start) userInfo:nil repeats:YES];
        
    });
    
    return locationManager;
}


- (void)start
{
    //判断系统
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        //允许定位，需要在info.plist里面添加字段，并且和此处保持一致
        _manager = [[CLLocationManager alloc] init];
        //设置权限为一直允许定位
        [_manager requestWhenInUseAuthorization];
    }
    //定位管理类的代理（编码，反编码）
    _manager.delegate = self;
    //位置信息更新最小距离，只有移动大于这个距离才更新位置信息，默认为kCLDistanceFilterNone：不进行距离限制
    _manager.distanceFilter = 1000;
    //开始定位
    [_manager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //如果不需要实时定位，使用完即使关闭定位服务
    [_manager stopUpdatingHeading];
    CLLocation *location = [locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    self.longitude = coordinate.longitude;
    self.latitude = coordinate.latitude;
    
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userLocationByLongitude:latitude:)]) {
        [self.delegate userLocationByLongitude:self.longitude latitude:self.latitude];
    }
    //反编码
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            //State(城市)  SubLocality(区)
            self.city = [test objectForKey:@"State"];
            self.area = [test objectForKey:@"SubLocality"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            
            userLocationModel *locationModel = [[userLocationModel alloc] initWithUserLongtitude:_longitude latitude:_latitude city:_city area:_area];
            [[YCUserManager sharedUserManager] setUserLocation:locationModel];

            
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userLocationByCity:area:)]) {
                [self.delegate userLocationByCity:self.city area:self.area];
            }
            });
        }
    }];
}

- (void)distanceBetweenOrderByOtherLocationLatitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CGFloat distance  = [userLocation distanceFromLocation:otherLocation];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(distanceBetweenOrder:)]) {
        [self.delegate distanceBetweenOrder:distance];
    }
}
- (CGFloat)distanceBetweenOrderByOtherLatitude:(CGFloat)latitude longitude:(CGFloat)longitude {
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CGFloat distance  = [userLocation distanceFromLocation:otherLocation];
    return distance;
}
@end
