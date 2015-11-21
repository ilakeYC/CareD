//
//  ScannerTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "ScannerTableViewCell.h"

@interface ScannerTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *scannerView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@end

@implementation ScannerTableViewCell

- (void)setUser:(AVUser *)user {
    
    Green_MakeTwoCodeView *view = [[Green_MakeTwoCodeView alloc] initWithTwoCodeString:user[CARED_LEANCLOUD_USER_userNameForScan] logoImage:nil viewframe:self.scannerView.bounds];
    
    [self.scannerView addSubview:view];
}

- (void)awakeFromNib {
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
