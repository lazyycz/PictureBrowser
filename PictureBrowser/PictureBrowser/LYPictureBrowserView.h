//
//  LYPictureBrowserView.h
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/13.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYPictureBrowserView;

typedef void(^didSelectPictureBrowserView)(LYPictureBrowserView *viwe, NSInteger index);

@interface LYPictureBrowserView : UIView

@property (nonatomic, copy) didSelectPictureBrowserView didSelectPictureBrowserViewBlock;

- (instancetype)initWithFrame:(CGRect)frame intervalTime:(NSTimeInterval)duringTime;

- (void)setDataSource:(NSArray<UIImage *> *)dataSource;

@end
