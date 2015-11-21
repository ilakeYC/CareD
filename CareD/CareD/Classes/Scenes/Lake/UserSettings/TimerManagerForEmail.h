//
//  TimerManagerForEmail.h
//  CareD
//
//  Created by LakesMac on 15/11/20.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManagerForEmail : NSObject

+ (instancetype)sharedTimerManager;

@property (nonatomic,assign) NSInteger second;

@end
