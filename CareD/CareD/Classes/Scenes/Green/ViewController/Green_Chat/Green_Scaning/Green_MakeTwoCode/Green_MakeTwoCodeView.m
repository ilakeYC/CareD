//
//  Green_MakeTwoCodeView.m
//  UI_二维码扫描
//
//  Created by 慈丽娟 on 15/11/10.
//  Copyright © 2015年 clj. All rights reserved.
//

#define kWidth self.imageView.frame.size.width
#define kHeight self.imageView.frame.size.height

#import "Green_MakeTwoCodeView.h"
#import "QRCodeGenerator.h"


@interface Green_MakeTwoCodeView ()
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIImageView * logoImageView;

@end

@implementation Green_MakeTwoCodeView


- (instancetype) initWithTwoCodeString:(NSString *)codeStr logoImage:(NSString *)logoImageName viewframe:(CGRect)frame
{
    if (self = [super init]) {
    
         self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
        [self setImageWithCodeStr:codeStr];

        //     logoImageView
        self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:logoImageName]];
        self.logoImageView.frame = CGRectMake(0, 0, 30, 30);
        self.logoImageView.center = self.imageView.center;
        [self.imageView addSubview:self.logoImageView];
    }
    return self;
}


- (void)setImageWithCodeStr:(NSString *)codeStr{
    UIImage * strimage = [ QRCodeGenerator qrImageForString:codeStr imageSize:self.imageView.frame.size.width];
     self.imageView.image = strimage;
}
@end
