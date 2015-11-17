//
//  tableListCell.m
//  CareD
//
//  Created by LakesMac on 15/11/14.
//  Copyright © 2015年 Tec-Erica. All rights reserved.
//

#import "tableListCell.h"

@interface tableListCell ()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;


@end

@implementation tableListCell

- (void)setUser:(AVUser *)user {
    self.mainTitleLabel.text = user[@"nickName"];
    self.mainImageView.image = [UIImage imageNamed:@"Icon-512"];
    
    [[YCUserImageManager sharedUserImage] getImageWithUser:user handel:^(UIImage *image) {
       
        self.mainImageView.image = image;
        
    }];
}

- (void)awakeFromNib {
    
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, -1);
    self.shadowView.layer.shadowOpacity = 0.7;
    
    self.mainContentView.layer.cornerRadius = 10;
    self.mainContentView.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
