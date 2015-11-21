//
//  Green_FriendSettingTableViewController.m
//  Green_RongYun
//
//  Created by 慈丽娟 on 15/11/14.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_FriendSettingTableViewController.h"
#import "Green_FriendSetSwitchCell.h"
#import "Green_BackImageViewController.h"



@interface Green_FriendSettingTableViewController () <Green_FriendSetSwitchCellDelegate>

@property (nonatomic, strong)UIView * dayView;
@end

@implementation Green_FriendSettingTableViewController
 static  NSString  * switchCell = @"greenswitchCell";
 static  NSString  * switchCell2 = @"greenswitchCell2";
 static NSString * systemCell = @"SystemCell";




- (void)viewDidLoad {
    [super viewDidLoad];
    self.dayView = [UIView new];

//     注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Green_FriendSetSwitchCell" bundle:nil] forCellReuseIdentifier:switchCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"Green_FriendSetSwitchCell" bundle:nil] forCellReuseIdentifier:switchCell2];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCell];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
 if (indexPath.section == 0){
        if (indexPath.row == 0) {
             Green_FriendSetSwitchCell * cell2 = [tableView dequeueReusableCellWithIdentifier:switchCell forIndexPath:indexPath];
            cell2.greenName.text = @"置顶聊天";
            cell2.delegate = self;
            NSString * key = @"GreenFriendChatkSwitch";
            key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
            NSNumber * selectSwitch = [[NSUserDefaults standardUserDefaults]objectForKey:key];
            BOOL select = selectSwitch.boolValue;
            [cell2.greenSwitch setOn:select];
            
                 return cell2;
        }else{
            Green_FriendSetSwitchCell * cell22 = [tableView dequeueReusableCellWithIdentifier:switchCell forIndexPath:indexPath];
            cell22.greenName.text = @"消息免打扰";
            cell22.delegate = self;
            NSString * key =@"GreenFriendQuickSwitch";
            key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
            NSNumber * selectSwitch = [[NSUserDefaults standardUserDefaults]objectForKey:key];
            BOOL select = selectSwitch.boolValue;
            [cell22.greenSwitch setOn:select];
            return cell22;
        }
   
    }else {
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:systemCell forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                cell3.textLabel.text = @"设置当前聊天背景";
                break;
            case 1:
                cell3.textLabel.text = @"清空会话列表";
                break;
                case 2:
                cell3.textLabel.text = @"删除聊天记录";
                break;
            default:
                break;
        }
        return cell3;
  }
}
#pragma mark 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //                 设置当前聊天背景
            Green_BackImageViewController * backImageVC = [[Green_BackImageViewController alloc]init];
            [self.navigationController pushViewController:backImageVC animated:YES];
            backImageVC.userInfor = self.userInfor;
            
        }else if(indexPath.row == 1)
        {
            //             清空会话列表
            [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_PRIVATE targetId:self.userInfor.userId];
            //            AlertView
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空会话列表成功" preferredStyle:UIAlertControllerStyleAlert];
            [self performSelector:@selector(clearConversationAlertVC:) withObject:alertVC afterDelay:1.0];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else if(indexPath.row == 2){
            //     删除某一会话的所有消息 （本地缓存也删除）
            [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_PRIVATE targetId:self.userInfor.userId];
            //  同时清除UI 上的数据， 执行代理方法
            if ((self.delegate!= nil )&&([self.delegate respondsToSelector:@selector(clearMessages)])) {
                [self.delegate clearMessages];
            }
            //            AlertView
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除聊天记录成功" preferredStyle:UIAlertControllerStyleAlert];
            [self performSelector:@selector(dismissAlertVC:) withObject:alertVC afterDelay:1.0];
            [self presentViewController:alertVC animated:YES completion:nil];
        }

    }
}


#pragma mark Alert 定时消失
- (void)dismissAlertVC:(UIAlertController *)sender
{
    [sender dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearConversationAlertVC:(UIAlertController *)sender
{
    [sender dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark Green_FriendSetSwitchCellDelegate 的代理方法
// 免打扰模式
- (void)greenSwitchActionMessageWithSwitch:(UISwitch *)greenSwitch
{
    NSLog(@"greenSwitch = %d", greenSwitch.on);
//    使用NSUserDefaults
    NSString * key =@"GreenFriendQuickSwitch";
    key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
    NSUserDefaults * userDefault =  [NSUserDefaults standardUserDefaults];
    NSNumber *switchBooL = [NSNumber numberWithBool:greenSwitch.on];
    [userDefault setObject:switchBooL forKey:key];

    if (greenSwitch.isOn == YES) {
        //                消失免打扰
        //     消息免打扰 (获取会话消息提醒状态)
        //    *  @param conversationType 会话类型。
        //    *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
        //    *  @param isBlocked        是否屏蔽。
        //    *  @param successBlock     调用完成的处理。
        //    *  @param errorBlock       调用返回的错误信息。
        [[RCIMClient sharedRCIMClient]setConversationNotificationStatus:ConversationType_PRIVATE targetId:self.userInfor.userId isBlocked:YES success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@" 消息免打扰conversation2 = %lu",(unsigned long)nStatus);
        } error:^(RCErrorCode status) {
        }];
        NSLog(@"123");
    }else{
//         不开启
        [[RCIMClient sharedRCIMClient]setConversationNotificationStatus:ConversationType_PRIVATE targetId:self.userInfor.userId isBlocked:NO success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@" 消息免打扰conversation2 = %lu",(unsigned long)nStatus);
        } error:^(RCErrorCode status) {
        }];
        NSLog(@"567");
    }
}


// 是否置顶聊天
- (void)greenSwitchActionDayWithSwitch:(UISwitch *)greenSwitch
{
    NSString * key = @"GreenFriendChatkSwitch";
    // 存到NSUserDeflauts
    key = [key stringByAppendingFormat:@"%@",self.userInfor.userId];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:greenSwitch.on] forKey:key];
    
    NSArray * chatArray = [[Green_RCUserManage shareRCUserManage]getAllRCUserInforArray];
    if (greenSwitch.isOn == YES) {
         //本程序只是支持一个用户置顶，（两个用户无法实现置顶， 所以当新的置顶后覆盖之前的）
    for (RCUserInfo * newUserInfor in chatArray) {
        //    得到key 值
    key = [key stringByAppendingFormat:@"%@",newUserInfor.userId];
            //                   取出value
          if ([self.userInfor.userId isEqualToString:newUserInfor.userId]) {
            // 置顶
                [[RCIMClient sharedRCIMClient]setConversationToTop:ConversationType_PRIVATE targetId:newUserInfor.userId isTop:YES];
            
           }else{
                   // 取出判断之前是否有置顶的， 有则去取消
                   NSNumber  * select= [[NSUserDefaults standardUserDefaults]objectForKey:key];
                   BOOL  boolSelect = [select boolValue];
                   if (boolSelect == YES) {
//                       取消置顶
                       [[RCIMClient sharedRCIMClient]setConversationToTop:ConversationType_PRIVATE targetId:newUserInfor.userId isTop:NO];
                   }
              }
          }
    }else{
//         取消置顶之后，判断有没有置顶的，有则置顶
        for (RCUserInfo * newuserInfor  in chatArray) {
            if ([newuserInfor.userId isEqualToString:self.userInfor.userId]) {
                [[RCIMClient sharedRCIMClient]setConversationToTop:ConversationType_PRIVATE targetId:self.userInfor.userId isTop:NO];
            }else{
                [[RCIMClient sharedRCIMClient]setConversationToTop:ConversationType_PRIVATE targetId:newuserInfor.userId isTop:YES];
            }
        }
    }
}



@end

