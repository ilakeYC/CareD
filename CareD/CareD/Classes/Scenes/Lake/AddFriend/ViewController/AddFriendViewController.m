//
//  AddFriendViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/16.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendView.h"

@interface AddFriendViewController ()

@property (nonatomic,strong) AddFriendView *addFriendView;

@end

@implementation AddFriendViewController

- (void)loadView {
    self.addFriendView = [[AddFriendView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.addFriendView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setUser:(AVUser *)user {
    _user = user;
    [[YCUserImageManager sharedUserImage] getImageUrlWithUser:user handel:^(NSString *URL) {
        if (!URL) {
            return ;
        }
        [self.addFriendView.imageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:self.image];
        
    }];
    
}


- (void)backToLastVC {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
