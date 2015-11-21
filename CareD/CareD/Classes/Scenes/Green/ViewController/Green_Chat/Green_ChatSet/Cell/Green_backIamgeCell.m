//
//  Green_backIamgeCell.m
//  CareD
//
//  Created by 慈丽娟 on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//


#import "Green_backIamgeCell.h"
@interface Green_backIamgeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;


@end


@implementation Green_backIamgeCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setImagName:(NSString *)imagName
{
    self.photoImage.image = [UIImage imageNamed:imagName];
}


@end
