//
//  Green_FriendSetSwitchCell.m
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/14.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_FriendSetSwitchCell.h"
@interface Green_FriendSetSwitchCell ()




@end


@implementation Green_FriendSetSwitchCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    }

- (IBAction)greenSwitchAction:(UISwitch *)sender {
    if (self.delegate!=nil) {
        if (([self.delegate respondsToSelector:@selector(greenSwitchActionDayWithSwitch:)]) &([self.greenName.text isEqualToString:@"置顶聊天"])){
            [self.delegate greenSwitchActionDayWithSwitch:sender];
        }else if (([self.delegate respondsToSelector:@selector(greenSwitchActionMessageWithSwitch:)])&&([self.greenName.text isEqualToString:@"消息免打扰"])){
            [self.delegate greenSwitchActionMessageWithSwitch:sender];
        }
    }
}

@end
