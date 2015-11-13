//
//  RegisterSettingsViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/12.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "RegisterSettingsViewController.h"

@interface RegisterSettingsViewController ()

@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UIView *imageMasksView;





@end

@implementation RegisterSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    [self.view addSubview:view];
    
    self.imageBackView.layer.cornerRadius = (CareD_Lake_MainScreenBounds.size.width * 0.382) / 2;
    self.imageBackView.layer.masksToBounds = YES;
    
    self.imageMasksView.layer.cornerRadius = (CareD_Lake_MainScreenBounds.size.width * 0.382) / 2 - 8;
    self.imageMasksView.layer.masksToBounds = YES;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

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
