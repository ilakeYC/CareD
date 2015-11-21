//
//  TimerManagerForEmail.m
//  CareD
//
//  Created by LakesMac on 15/11/20.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "TimerManagerForEmail.h"

@interface TimerManagerForEmail ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation TimerManagerForEmail

+ (instancetype)sharedTimerManager {
    static TimerManagerForEmail *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (void)setSecond:(NSInteger)second {
    _second = second;
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBegin) userInfo:nil repeats:YES];
//    self.second -= 1;
    
    if (_second <= 0) {
        _second = 0;
//        [self.timer invalidate];
//        self.timer = nil;
    }
    
}

- (void)timerBegin {
    
    self.second -= 1;
    
    if (self.second <= 0) {
        self.second = 0;
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

@end
