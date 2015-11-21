//
//  EmailTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "EmailTableViewCell.h"

@interface EmailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *emainLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation EmailTableViewCell

- (void)awakeFromNib {
    
    NSNumber *number = [AVUser currentUser][@"emailVerified"];
    BOOL isVerified = number.boolValue;
    
    self.emainLabel.text = [AVUser currentUser].email;
    if (isVerified) {
        self.stateLabel.text = @"邮箱已验证";
        self.stateLabel.textColor = [UIColor greenColor];
    } else {
        self.stateLabel.text = @"邮箱未验证";
        self.stateLabel.textColor = CareD_Lake_COLOR_WorningRed;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
