//
//  SignoutTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "SignoutTableViewCell.h"

@interface SignoutTableViewCell ()


@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation SignoutTableViewCell

- (void)awakeFromNib {
    
    self.buttonView.layer.cornerRadius = 10;
    self.buttonView.backgroundColor = CareD_Lake_COLOR_WorningRed;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
