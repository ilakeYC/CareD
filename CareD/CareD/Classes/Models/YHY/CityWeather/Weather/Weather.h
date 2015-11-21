//
//  Weather.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather_info.h"

@interface Weather : NSObject

/*
 "date": "2015-11-10",
 "info": {},
 "week": "二",
 "nongli": "九月廿九"
*/
@property (nonatomic, copy) NSString *date;//日期
@property (nonatomic, strong) NSDictionary *info;//详情
@property (nonatomic, copy) NSString *week;//星期*
@property (nonatomic, copy) NSString *nongli;//农历时间


@end
