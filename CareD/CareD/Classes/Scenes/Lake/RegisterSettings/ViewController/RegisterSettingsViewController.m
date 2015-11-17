//
//  RegisterSettingsViewController.m
//  CareD
//
//  Created by LakesMac on 15/11/12.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "RegisterSettingsViewController.h"
#import "imagePickerChooseView.h"


@interface RegisterSettingsViewController ()<imagePickerChooseViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,YCUserImageManagerDelegate>
{
    BOOL _hasNickName;
    BOOL _hasImage;
}

@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UIView *imageMasksView;

@property (weak, nonatomic) IBOutlet UIView *textFieldBackView;
@property (weak, nonatomic) IBOutlet UIView *textFieldLineView;

@property (weak, nonatomic) IBOutlet UIButton *addImageButton;


@property (weak, nonatomic) IBOutlet UIView *saveSettingsBackView;
@property (weak, nonatomic) IBOutlet UIButton *saveSettingsButton;

@property (nonatomic,strong) imagePickerChooseView *imagePickerChooseView;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;

@property (weak, nonatomic) IBOutlet UILabel *userImageTipLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,copy) NSString *imageURL;
@property (weak, nonatomic) IBOutlet UITextField *userNickNameTextField;

@property (nonatomic,strong) YCUserManager *userManager;


@property (weak, nonatomic) IBOutlet UIView *progressViewBackView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;


@end

@implementation RegisterSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CareD_Lake_MainScreenBounds.size.width, 64)];
    view.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    [self.view addSubview:view];
    

    self.navigationItem.titleView = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = @"设置你的基本信息";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor whiteColor];
        label;
    
    });
    
    self.progressViewBackView.alpha = 0;
    
    self.userNickNameTextField.delegate = self;
    
    self.saveSettingsBackView.layer.cornerRadius = 10;
    self.saveSettingsBackView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.saveSettingsBackView.layer.borderWidth = 1;
    
    
    self.textFieldBackView.layer.cornerRadius = 15;
    self.textFieldBackView.layer.shadowOffset = CGSizeMake(0, -1);
    self.textFieldBackView.layer.shadowOpacity = 0.7;
    self.textFieldBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    self.imageBackView.layer.cornerRadius = (CareD_Lake_MainScreenBounds.size.width * 0.382) / 2;
    self.imageBackView.layer.masksToBounds = YES;
    
    self.imageMasksView.layer.cornerRadius = (CareD_Lake_MainScreenBounds.size.width * 0.382) / 2 - 8;
    self.imageMasksView.layer.masksToBounds = YES;
    
    
    self.imagePickerChooseView = [imagePickerChooseView new];
    self.imagePickerChooseView.delegate = self;
 
    [self.saveSettingsButton addTarget:self action:@selector(saveSettings:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.userManager = [YCUserManager sharedUserManager];
}
//设置旋转
- (void)viewDidAppear:(BOOL)animated {

    [NSTimer scheduledTimerWithTimeInterval:0.003 target:self selector:@selector(buttonRotation) userInfo:nil repeats:YES];
    
}
- (void)buttonRotation {
        self.addImageButton.layer.affineTransform = CGAffineTransformRotate(self.addImageButton.layer.affineTransform, -M_PI * 0.0003);
}

//设置头像按钮动作
- (IBAction)addImageButtonAction:(UIButton *)sender {
    NSLog(@"\n%d,\n%s\n",__LINE__,__FUNCTION__);
    [self.imagePickerChooseView showAndClickedButtonAtIndex:^(NSInteger *index) {
        
    }];
}

//点击屏幕取消编辑状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark imagePickerChooseView Delegete 
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
    self.imageURL = imageFilePath;
    [self.userImageView setImage:selfPhoto];
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        if (self.userImageView.image != nil) {
            _hasImage = YES;
            [UIView animateWithDuration:1 animations:^{
                self.userImageTipLabel.alpha = 0;
            }];
            [self.userImageView removeObserver:self forKeyPath:@"image"];
        }
    }
}

#pragma mark textField Delegage 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        _hasNickName = YES;
    } else {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]) {
        _hasNickName = YES;
    } else {
        return NO;
    }
    return YES;
}

#pragma mark 保存设置
- (void)saveSettings:(UIButton *)sender {
    if (_hasImage && _hasNickName) {
        
        [YCUserImageManager sharedUserImage].delegate = self;
        [UIView animateWithDuration:1 animations:^{
            self.progressViewBackView.alpha = 1;
            self.progressLabel.text = @"正在保存设置";
            self.saveSettingsBackView.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performSelector:@selector(upDataSettings) withObject:self afterDelay:1];
            }
        }];
        
        
    }else{
        if (!_hasNickName) {
         
            self.textFieldLineView.backgroundColor = CareD_Lake_COLOR_WorningRed;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            [UIView setAnimationDelay:1];
            self.textFieldLineView.backgroundColor = [UIColor whiteColor];
            [UIView commitAnimations];
            
            
        }
        if (!_hasImage) {
            
            self.imageBackView.backgroundColor = CareD_Lake_COLOR_WorningRed;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            [UIView setAnimationDelay:1];
            self.imageBackView.backgroundColor = CareD_Lake_COLOR_AbsintheGreen;
            [UIView commitAnimations];
            
        }
    }
}

- (void)upDataSettings {
    [self.userManager setUserNickName:self.userNickNameTextField.text];
    [[YCUserImageManager sharedUserImage] setUserImage:self.userImageView.image];
}

#pragma mark - userDelegate
///上传进度
- (void)imageUpLoadingProgress:(NSInteger)percent {
    self.progressView.progress = percent / 100;
}
///上传成功
- (void)imageUpLoadComplete {
    self.progressLabel.text = @"设置保存成功";
    [self performSelector:@selector(presentFriendListViewController) withObject:self afterDelay:1];
}
///上传失败
- (void)imageUpLoadFailure {
    self.progressLabel.text = @"保存失败，请再试一次";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:3];
    [UIView setAnimationDuration:2];
    self.saveSettingsBackView.alpha = 1;
    self.progressViewBackView.alpha = 0;
    [UIView commitAnimations];
}

- (void)presentFriendListViewController {
    FriendListViewController *friendListVC = [FriendListViewController new];
    UINavigationController *friendListNC = [[UINavigationController alloc] initWithRootViewController:friendListVC];
    
    friendListNC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:friendListNC animated:YES completion:^{
    }];
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:self.imageMasksView.bounds];
        [self.imageMasksView addSubview:_userImageView];
        [_userImageView addObserver:self forKeyPath:@"image" options:(NSKeyValueObservingOptionNew) context:@"image"];
    }
    return _userImageView;
}
@end
