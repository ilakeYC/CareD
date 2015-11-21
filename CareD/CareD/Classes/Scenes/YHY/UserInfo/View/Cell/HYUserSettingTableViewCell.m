//
//  HYUserSettingTableViewCell.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYUserSettingTableViewCell.h"
#import "TwoCodeView.h"

#define CareD_Lake_COLOR_AbsintheGreen [UIColor colorWithRed:136/255.f green:189/255.f blue:65/255.f alpha:1]

@interface HYUserSettingTableViewCell ()

@property (nonatomic,strong) TwoCodeView *twocodeView;

@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UIView *portraitView;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//二维码
- (IBAction)erWeiMaButton:(UIButton *)sender;



@end

@implementation HYUserSettingTableViewCell

- (void)awakeFromNib
{
    
    self.cellView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cellView.layer.shadowOffset =CGSizeMake(0, 1);
    self.cellView.layer.shadowOpacity = 0.6;
    
    self.portraitView.layer.masksToBounds = YES;
    self.portraitView.layer.cornerRadius = self.portraitView.frame.size.width / 2;
    
    AVUser *currentUser = [AVUser currentUser];
    
    self.nicknameLabel.text = currentUser[@"nickName"];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",currentUser.username];
    
    [[YCUserImageManager sharedUserImage] getImageWithUser:currentUser handel:^(UIImage *image) {
       
        self.headImageView.image = image;
        
    }];
    
    
}


- (IBAction)erWeiMaButton:(UIButton *)sender
{
    
    self.twocodeView = [TwoCodeView new];
    [self.twocodeView showView];
    NSLog(@"function == %s line == %d",__FUNCTION__,__LINE__);
    NSLog(@"二维码扫描");
}
@end
