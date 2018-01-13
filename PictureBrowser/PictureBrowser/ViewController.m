//
//  ViewController.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/13.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "LYPictureBrowserView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *data1 = @[
                       [UIImage imageNamed:@"image1.pic"],
                       [UIImage imageNamed:@"image2.pic"],
                       [UIImage imageNamed:@"image3.pic"],
                       [UIImage imageNamed:@"image4.pic"],
                       [UIImage imageNamed:@"image5.pic"],
                       [UIImage imageNamed:@"image6.pic"],
                       [UIImage imageNamed:@"image7.pic"],
                       [UIImage imageNamed:@"image8.pic"],
                       ];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width * 9 / 16;
    
    [self.view addSubview:({
        LYPictureBrowserView *pictureBrowserView = [[LYPictureBrowserView alloc] initWithFrame:CGRectMake(0, 20, width, height) intervalTime:3];
        [pictureBrowserView setDataSource:data1];
        pictureBrowserView.didSelectPictureBrowserViewBlock = ^(LYPictureBrowserView *viwe, NSInteger index) {
            NSLog(@"\ndid selected index = %ld", (long)index);
        };
        pictureBrowserView;
    })];
}

@end
