//
//  UserNameTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserNameTableViewCell.h"

@interface UserNameTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation UserNameTableViewCell

- (void)awakeFromNib {
    
    self.userNameLabel.text = [AVUser currentUser].username;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
