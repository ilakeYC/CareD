//
//  HYUserInfoViewController.m
//  Demo_Cared
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 Sir_乔巴. All rights reserved.
//

#import "HYUserInfoViewController.h"
#import "HYUserSettingTableViewCell.h"
#import "HYWeatherTableViewCell.h"
//天气
#import "UserWeather.h"

#define kUserSettingTVCellIdentifier @"userSetCell"
#define kWeatherTVCellIdentifier @"weatherCell"
#define CareD_Lake_COLOR_AbsintheGreen [UIColor colorWithRed:136/255.f green:189/255.f blue:65/255.f alpha:1]
#define kMainScreen [UIScreen mainScreen].bounds

@interface HYUserInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation HYUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = ({
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = @"我的、在乎的";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label;
        
    });
    
    self.backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.backButton setImage:[UIImage imageNamed:@"backButton_down"] forState:(UIControlStateNormal)];
    [self.backButton setTintColor:[UIColor whiteColor]];
    self.backButton.frame = CGRectMake(0, 0, 30, 30);
    [self.backButton addTarget:self action:@selector(backFriendListViewController) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];

    [self addControls];
    
}

- (void)addControls
{
    //创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.bounces = NO;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HYUserSettingTableViewCell" bundle:nil] forCellReuseIdentifier:kUserSettingTVCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"HYWeatherTableViewCell" bundle:nil] forCellReuseIdentifier:kWeatherTVCellIdentifier];
   
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)backFriendListViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        HYUserSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserSettingTVCellIdentifier forIndexPath:indexPath];
        //取消cell点击是的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.row == 1){
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        HYWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWeatherTVCellIdentifier forIndexPath:indexPath];
        //取消cell点击是的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userWeather = [YHYWeatherManger sharedYHYWeatherManager].currentUserWeather;
    
        
        return cell;
        
    }else{
        return nil;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1){
        return 220;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 0) {
        UserSettingsViewController *userSettingsVC = [UserSettingsViewController new];
        [self.navigationController pushViewController:userSettingsVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
