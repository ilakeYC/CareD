//
//  imagePickerChooseView.h
//  CareD
//
//  Created by LakesMac on 15/11/13.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol imagePickerChooseViewDelegate;
@interface imagePickerChooseView : UIView

@property (nonatomic,assign) id<imagePickerChooseViewDelegate> delegate;

- (void)showAndClickedButtonAtIndex:(void (^)(NSInteger *index))handle;
- (void)hidden;

@end

@protocol imagePickerChooseViewDelegate <NSObject>

- (void)clickButtonAtIndex:(NSInteger)index;

@end