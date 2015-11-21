//
//  Wind.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wind : NSObject

/*
 "direct": "南风",
 "power": "1级",
 "offset": null,
 "windspeed": null
*/

@property (nonatomic, copy) NSString *direct;//风向
@property (nonatomic, copy) NSString *power;//风力等级
@property (nonatomic, copy) NSString *offset;//偏向
@property (nonatomic, copy) NSString *windspeed;//风速





@end
