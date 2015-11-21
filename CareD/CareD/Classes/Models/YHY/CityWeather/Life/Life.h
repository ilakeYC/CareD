//
//  Life.h
//  Test
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Life_info.h"
@interface Life : NSObject

/*
  "date": "2015-11-10",
  "info": {
  "chuanyi": [],
  "ganmao": [],
  "kongtiao": [],
  "wuran": [],
  "xiche": [],
  "yundong": [],
  "ziwaixian": []
 }
*/

@property (nonatomic, copy) NSString *date;//日期
@property (nonatomic, strong) NSDictionary *info;//详情


@end
