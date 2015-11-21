//
//  Green_MapViewViewController.h
//  Green_RongYun_Demo
//
//  Created by 慈丽娟 on 15/11/17.
//  Copyright © 2015年 clj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Green_MapViewViewController : UIViewController


+(instancetype) shareMapViewController;
// 传进来的经纬度
@property (nonatomic, assign) CLLocationCoordinate2D  cllocation2D;

@end
