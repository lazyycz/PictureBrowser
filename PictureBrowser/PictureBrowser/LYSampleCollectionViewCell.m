//
//  LYSampleCollectionViewCell.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/13.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "LYSampleCollectionViewCell.h"

@interface LYSampleCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LYSampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

- (void)reloadCellWithImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imageView;
}

@end
