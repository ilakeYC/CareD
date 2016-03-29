//
//  UserSettingsViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/18.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "UserSettingsView.h"

#import "imagePickerChooseView.h"

#import "UserImageTableViewCell.h"
#import "UserNickNameTableViewCell.h"
#import "UserNameTableViewCell.h"
#import "ScannerTableViewCell.h"
#import "EmailTableViewCell.h"
#import "ResetPasswordTableViewCell.h"
#import "SignoutTableViewCell.h"

#import "SetNickNameViewController.h"
#import "SetEmailViewController.h"
#import "SetPasswordViewController.h"

@interface UserSettingsViewController ()<UITableViewDataSource,UITableViewDelegate,imagePickerChooseViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UserSettingsView *userSettingsView;
@property (nonatomic,strong) imagePickerChooseView *imagePickerChooseView;


@end

@implementation UserSettingsViewController

static NSString *const userImageCellID    = @"userImageCell";
static NSString *const userNickNameCellID = @"userNickNameCell";
static NSString *const userNameCellID     = @"userNameCell";
static NSString *const userScannerCellID  = @"scannerCell";
static NSString *const userEmailCellID    = @"emainCell";
static NSString *const userPasswordCellID = @"resetPasswordCell";
static NSString *const signoutCellID      = @"signoutCell";

- (void)loadView {
    self.userSettingsView = [[UserSettingsView alloc] initWithFrame:CareD_Lake_MainScreenBounds];
    self.view = self.userSettingsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"设置中心";
        label.font = [UIFont systemFontOfSize:22];
        label;
    });
    
    
    self.userSettingsView.tableView.alwaysBounceVertical = NO;
    self.userSettingsView.tableView.delegate = self;
    self.userSettingsView.tableView.dataSource = self;
    self.userSettingsView.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        view;
    });
    
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"UserImageTableViewCell" bundle:nil] forCellReuseIdentifier:userImageCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"UserNickNameTableViewCell" bundle:nil] forCellReuseIdentifier:userNickNameCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"UserNameTableViewCell" bundle:nil] forCellReuseIdentifier:userNameCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"ScannerTableViewCell" bundle:nil] forCellReuseIdentifier:userScannerCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"EmailTableViewCell" bundle:nil] forCellReuseIdentifier:userEmailCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"ResetPasswordTableViewCell" bundle:nil] forCellReuseIdentifier:userPasswordCellID];
    [self.userSettingsView.tableView registerNib:[UINib nibWithNibName:@"SignoutTableViewCell" bundle:nil] forCellReuseIdentifier:signoutCellID];
    
}

#pragma mark - tableView Delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UserImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userImageCellID forIndexPath:indexPath];
        
        cell.user = [AVUser currentUser];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        
        UserNickNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userNickNameCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 2) {
        UserNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userNameCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 3) {
        
        ScannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userScannerCellID forIndexPath:indexPath];
        cell.user = [AVUser currentUser];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 4) {
        
        EmailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userEmailCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 5) {
        
        ResetPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userPasswordCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 6) {
        
        SignoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:signoutCellID  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 97;
    }
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
        return 50;
    }
    if (indexPath.row == 3) {
        return 168;
    }
    if ( indexPath.row == 6) {
        return 90;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            self.imagePickerChooseView = [[imagePickerChooseView alloc] init];
            self.imagePickerChooseView.delegate = self;
            [self.imagePickerChooseView showAndClickedButtonAtIndex:^(NSInteger *index){}];
            break;
        case 6: {

            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认注销登录吗" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                [[YCUserManager sharedUserManager] logOut];
               // logout Rongyun
                [[RCIM sharedRCIM]disconnect];
                
                LoginViewController *loginVC = [LoginViewController new];
                
                [self presentViewController:loginVC animated:YES completion:^{
                    
                }];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 1: {
            SetNickNameViewController *setNickNameVC = [[SetNickNameViewController alloc] initWithNibName:@"SetNickNameViewController" bundle:nil];
            [self.navigationController pushViewController:setNickNameVC animated:YES];
            
            
            break;
        }
        case 4: {
            
            SetEmailViewController *emailVC = [[SetEmailViewController alloc] init];
            [self.navigationController pushViewController:emailVC animated:YES];
            
            break;
        }
        case 5: {
            
            SetPasswordViewController *passwdVC = [SetPasswordViewController new];
            [self.navigationController pushViewController:passwdVC animated:YES];
            
        }
        default:
            break;
    }
    
    
}


#pragma mark - imagePickers 
- (void)clickButtonAtIndex:(NSInteger)index {
    
    if (index == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    } else {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //            [self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(1024, 1024)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    
    
    UserImageTableViewCell *cell = [self.userSettingsView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell hiddenImage];
    
    [[YCUserImageManager sharedUserImage] setUserImage:selfPhoto completeBlock:^(BOOL successed) {
        

        
//        if (successed) {
            NSLog(@"设置完成");
        
        [[YCUserImageManager sharedUserImage] getImageUrlWithUser:[AVUser currentUser] handel:^(NSString *URL) {
#warning ------change Image there 头像改了以后的url

            NSString *myuserNameForToken = [AVUser currentUser][CARED_LEANCLOUD_USER_userNameForChat];
           NSString *myuserName = [AVUser currentUser][@"nickName"];
            RCUserInfo *userInfor = [[RCUserInfo alloc]initWithUserId:myuserNameForToken name:myuserName portrait:URL];
            [[RCIM sharedRCIM]refreshUserInfoCache:userInfor
                                        withUserId:myuserNameForToken];
            
        }];
        
            [cell showImage:^{
                [self.userSettingsView.tableView reloadData];
            }];
            
//        }
        
    } progress:^(NSInteger progress) {
       
        cell.progressView.progress = progress * 0.01;
        
        NSLog(@"设置完成%ld",progress);
        
    }];
    
}
// 改变图像的尺寸，方便上传服务器
- (UIImage *)scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    //    }
    
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}







@end
