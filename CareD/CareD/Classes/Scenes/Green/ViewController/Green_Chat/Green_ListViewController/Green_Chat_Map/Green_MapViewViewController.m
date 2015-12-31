
//
//  Green_MapViewViewController.m
//  Green_RongYun_Demo
//
//  Created by 慈丽娟 on 15/11/17.
//  Copyright © 2015年 clj. All rights reserved.
//


/*
 使用系统定位
 */
#import "Green_MapViewViewController.h"



@interface Green_MapViewViewController () <MAMapViewDelegate, AMapSearchDelegate>
// 地图
@property (nonatomic, strong) MAMapView * mapView;
// 地理编码
@property (nonatomic, strong) AMapSearchAPI * search;
// 大头针
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;

@end

@implementation Green_MapViewViewController


+(instancetype)shareMapViewController
{
    static  Green_MapViewViewController * mapVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapVC = [Green_MapViewViewController new];
    });
    return mapVC;
}

- (instancetype) init
{
    if (self = [super init]) {
        self.navigationController.navigationBar.translucent = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

   [MAMapServices sharedServices].apiKey = @"ffeb6e6a0da506b32370452e71e58f56";
//     添加mapView
    self.mapView =[[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
//     初始化AMapSearchAPI 对象，并设置代理
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    self.pointAnnotation = [[MAPointAnnotation alloc] init];
    [self.mapView addAnnotation:self.pointAnnotation];
    
//     开启定位
//    self.mapView.showsUserLocation = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    //     逆地理编码
    [AMapSearchServices sharedServices].apiKey = @"ffeb6e6a0da506b32370452e71e58f56";
    //     构造AMapReGeocodeSearchRequest 对象
    AMapReGeocodeSearchRequest * request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.cllocation2D.latitude longitude:self.cllocation2D.longitude];
    request.radius = 1000;
    //  发起逆地理编码
    [self.search AMapReGoecodeSearch:request];
}

#pragma  mark 逆地理编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode !=nil) {
//        逆地理编码所有信息
        AMapReGeocode * regeocode = response.regeocode;
//        地址组成要素
        AMapAddressComponent * addressComponent = regeocode.addressComponent;
//        省份
        NSString * province = addressComponent.province;
//         城市
        NSString * newTitle = nil;
        NSString * city = addressComponent.city;
        if (province!= nil && city!=nil) {
           newTitle = [province stringByAppendingString:city];
        }else{
            if (province!=nil) {
                newTitle = province;
            }else{
                newTitle = city;
            }
        }
      
//         区
        NSString *district = addressComponent.district;
         NSLog(@"district = %@", district);
//         街道
        NSString *township = addressComponent.township;
        NSLog(@" township = %@", township);
        
        NSString * newsubTitle = nil;
        if (district!= nil && township!=nil) {
           newsubTitle = [district stringByAppendingString:township];
        }else{
            if (district!=nil) {
                newsubTitle = district;
            }else{
                newsubTitle = township;
            }
        }
        
//         添加大头针
        self.pointAnnotation.coordinate = self.cllocation2D;
        self.pointAnnotation.title = newTitle ;
        self.pointAnnotation.subtitle = newsubTitle;
    }
}



//#pragma mark 位置变化回调
//- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
//{
//    if (updatingLocation) {
////         取出当前位置的坐标
//       NSLog(@"location.latitude = %f, longitute = %f",userLocation.coordinate.latitude, userLocation.coordinate.longitude  );
//    self.cllocation2D =userLocation.coordinate;
//    }
//}


//
#pragma mark 添加大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString * pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView * annotationView =(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        
        if (!annotationView) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES; // 设置气泡可以弹出。 默认是NO
        annotationView.animatesDrop = YES;   // 设置标注动画显示， 默认是NO
        annotationView.draggable = YES;      // 设置标注可以拖动, 默认是NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
