//
//  Green_ScannerView.h
//  UI_二维码扫描
//
//  Created by 慈丽娟 on 15/11/16.
//  Copyright © 2015年 clj. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GreenScannerViewDelegate;

@interface Green_ScannerView : UIView

@property (assign) id<GreenScannerViewDelegate> delegate;

- (void)showScannerView;
- (void)hiddenScannerView;



@end


@protocol GreenScannerViewDelegate <NSObject>

@optional
- (void)scannerViewDidShow;
- (void)scannerViewDidHidden;

///输出扫描到的字符串
- (void)scannerViewDidFinishedScan:(NSString *)string;

@end