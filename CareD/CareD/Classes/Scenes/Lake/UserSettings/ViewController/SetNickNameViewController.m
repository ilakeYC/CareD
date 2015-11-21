//
//  SetNickNameViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/20.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "SetNickNameViewController.h"

@interface SetNickNameViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@end

@implementation SetNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainContentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.mainContentView.layer.shadowOpacity = 0.7;
    self.mainContentView.layer.cornerRadius = 10;
    self.mainContentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mainContentView.layer.borderWidth = 1;
    
    self.textField.text = [AVUser currentUser][@"nickName"];
    
    self.textField.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[YCUserManager sharedUserManager] setUserNickName:self.textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
