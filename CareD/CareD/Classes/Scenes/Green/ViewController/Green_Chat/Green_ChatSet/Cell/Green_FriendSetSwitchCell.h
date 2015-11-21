//
//  Green_FriendSetSwitchCell.h
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/14.
//  Copyright © 2015年 clj. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol Green_FriendSetSwitchCellDelegate<NSObject>

// switch 的代理方法
- (void)greenSwitchActionDayWithSwitch:(UISwitch *)greenSwitch;
- (void)greenSwitchActionMessageWithSwitch:(UISwitch *)greenSwitch;

@end


@interface Green_FriendSetSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *greenName;
@property (weak, nonatomic) IBOutlet UISwitch *greenSwitch;
@property (nonatomic, assign) id <Green_FriendSetSwitchCellDelegate> delegate;
@end
