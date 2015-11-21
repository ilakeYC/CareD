//
//  HYLocationManager.h
//  Demo_Cared
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HYLocationManagerDelegate <NSObject>

@optional
///返回城市、区
- (void)userLocationByCity:(NSString *)city
                      area:(NSString *)area;

///返回用户的经纬度
- (void)userLocationByLongitude:(CGFloat)longitude
                       latitude:(CGFloat)latitude;

///返回用户和其他联系人之间的距离(必须先调用方法，才能返回距离)
- (void)distanceBetweenOrder:(CGFloat)distance;

@end

@interface HYLocationManager : NSObject

+ (instancetype)sharedHYLocationManager;

@property (nonatomic, assign) id<HYLocationManagerDelegate> delegate;

///开始定位
- (void)start;
///计算与其他人之间的距离
- (void)distanceBetweenOrderByOtherLocationLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;
- (CGFloat)distanceBetweenOrderByOtherLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;

@end
