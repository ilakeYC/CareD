//
//  Green_ListViewController.m
//  Green_RongYun_Demo
//
//  Created by 慈丽娟 on 15/11/16.
//  Copyright © 2015年 clj. All rights reserved.
//

#import "Green_ListViewController.h"
#import "Green_ChatViewController.h"

@implementation Green_ListViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.emptyConversationView = ({
        UIView *view = [[UIView alloc] initWithFrame:CareD_Lake_MainScreenBoundsWithoutNavigationBar];
        view;
    });
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
//    Green_ChatViewController * chatVC = [[Green_ChatViewController alloc] init];
    Green_ChatViewController * chatVC = [[Green_ChatViewController alloc]init];
    
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = model.targetId;
    chatVC.userName = model.conversationTitle;
    chatVC.title = model.conversationTitle;
    [self.navigationController pushViewController:chatVC animated:YES];
}



@end


