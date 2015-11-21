//
//  UserNickNameTableViewCell.m
//  CareD
//
//  Created by LakesMac on 15/11/19.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserNickNameTableViewCell.h"

@interface UserNickNameTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;

@end

@implementation UserNickNameTableViewCell

- (void)awakeFromNib {
    self.userNickNameLabel.text = [AVUser currentUser][@"nickName"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
