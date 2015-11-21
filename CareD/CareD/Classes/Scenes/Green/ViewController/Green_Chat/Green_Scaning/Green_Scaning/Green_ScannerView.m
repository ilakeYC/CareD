//
//  Green_ScannerView.m
//  UI_二维码扫描
//
//  Created by 慈丽娟 on 15/11/16.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_ScannerView.h"
#import "ZBarSDK.h"


@interface Green_ScannerView ()<ZBarReaderViewDelegate>

@property (nonatomic,strong) UIWindow           *window;
@property (nonatomic,strong) UIView             *contentView;
@property (nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIView             *scannerView;
@property (nonatomic,strong) ZBarReaderView     *readerView;
@property (nonatomic,strong) UILabel            *label;

@end

@implementation Green_ScannerView


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)showScannerView {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    
    self.contentView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.contentView.alpha = 0;
    [self.window addSubview:self.contentView];
    
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.effectView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.effectView];
    
    self.scannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.effectView.bounds.size.width * 0.618, self.effectView.bounds.size.width * 0.618)];
    self.scannerView.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
    self.scannerView.alpha = 0;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 50, self.contentView.frame.size.width, 30)];
    self.label.text = @"点击任意位置关闭";
    self.label.textColor = [UIColor lightGrayColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:22];
    [self.contentView addSubview:self.label];
    
 
//    self.scannerView.layer.borderWidth = 1;
//    self.scannerView.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:self.scannerView];

    
//     添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenScannerView)];
    [self.contentView addGestureRecognizer:tap];
    
    //添加扫描窗口
    
//    self.readerView = [[ZBarReaderView alloc]initWithFrame:CGRectMake(0, 0, self.effectView.bounds.size.width * 0.618 , self.effectView.bounds.size.height * 0.618 )];
//    
//    self.readerView.center =  CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
//
    self.readerView = [[ZBarReaderView alloc] init];
    self.readerView.frame = self.scannerView.bounds;
//    self.readerView.center = self.scannerView.center;
    
    self.readerView.readerDelegate = self;
    //    torchmode 闪光灯， 默认2 自动， 0 是关闭
    _readerView.torchMode =0;
    //    显示帧率  YES 显示  NO 不显示
    //    _readerView.showsFPS = NO;
    //     使用手势变焦
    _readerView.allowsPinchZoom = YES;
    //     将被扫描的图像的区域
    //    _readerView.scanCrop = CGRectMake(0, 0, 1, 1);
    //                     扫描页面出现后开始扫描
    [self.readerView start];
    [self.scannerView addSubview:self.readerView];

   [self.window makeKeyAndVisible];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:self.scannerView.bounds];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor greenColor].CGColor;
    [self.scannerView addSubview:view];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:INT64_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    view.alpha = 0;
    [UIView commitAnimations];
    
    
    [UIView animateWithDuration:0.3 animations:^{
//        现出来contentView
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
               
//                 成功3 秒之后出现扫描页面
                self.scannerView.alpha = 1;
                
            } completion:^(BOOL finished) {
                
                if (finished) {

                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewDidShow)]) {
                        [self.delegate scannerViewDidShow];
                    }
                    
                    
                }
                
            }];
        }
    }];
    
    
    
    
}

- (void)hiddenScannerView {
   
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.scannerView.alpha = 0;
//        修改第三方 ZBarReaderView  修改 - (BOOL)returnStart{  return started }
        //    判断是否开启扫描
        if ([self.readerView returnStart] == YES) {
            //    停止扫描
            [self.readerView stop];
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                self.contentView.alpha = 0;
                
            } completion:^(BOOL finished) {
                
                if (finished) {
                
                    [self.window resignKeyWindow];
                    self.window = nil;
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewDidHidden)]) {
                        [self.delegate scannerViewDidHidden];
                    }
                    
                }
                
            }];
            
        }
    }];
}


#pragma mark ZBarReaderViewDelegate 代理方法
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol * symbol  in symbols) {
        
        if (symbol.type == ZBAR_QRCODE) {
            //             就是扫瞄中文的二维码乱码问题
            if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
                NSString * str = [NSString stringWithCString:[symbol.data cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
//                 代理方法返回str
                if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewDidFinishedScan:)]) {
                    [self.delegate scannerViewDidFinishedScan:str];
                }
            }else{
                NSString * str = [NSString stringWithCString:[symbol.data UTF8String] encoding:NSUTF8StringEncoding];
                if (self.delegate && [self.delegate respondsToSelector:@selector(scannerViewDidFinishedScan:)]) {
                    [self.delegate scannerViewDidFinishedScan:str];
            }
        }
    }
        break;
}
    
    //    扫描完之后返回
    [self hiddenScannerView];
}



@end
