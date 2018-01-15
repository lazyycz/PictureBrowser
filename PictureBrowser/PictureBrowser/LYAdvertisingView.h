//
//  LYAdvertisingView.h
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/15.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYAdvertisingView;

typedef void(^didSelectAdvertisingView)(LYAdvertisingView *viwe, NSInteger index);

@interface LYAdvertisingView : UIView

@property (nonatomic, copy) didSelectAdvertisingView didSelectAdvertisingViewBlock;

- (void)setDataSource:(NSArray<UIImage *> *)dataSource;

@end
