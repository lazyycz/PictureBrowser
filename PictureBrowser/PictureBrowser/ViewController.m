//
//  ViewController.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/13.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "LYPictureBrowserView.h"
#import "LYAdvertisingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width * 9 / 16;
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [data addObject:[self imageWithColor:[self randomColor] imageSize:CGSizeMake(width, height)]];
    }
    
    
    [self.view addSubview:({
        LYPictureBrowserView *pictureBrowserView = [[LYPictureBrowserView alloc] initWithFrame:CGRectMake(0, 20, width, height) intervalTime:3];
        [pictureBrowserView setDataSource:data.copy];
        pictureBrowserView.didSelectPictureBrowserViewBlock = ^(LYPictureBrowserView *viwe, NSInteger index) {
            NSLog(@"\ndid selected index = %ld", (long)index);
        };
        pictureBrowserView;
    })];
    
    [self.view addSubview:({
        LYAdvertisingView *advertisingView = [[LYAdvertisingView alloc] initWithFrame:CGRectMake(0, height + 50, width, height)];
        [advertisingView setDataSource:data.copy];
        advertisingView.didSelectAdvertisingViewBlock = ^(LYAdvertisingView *viwe, NSInteger index) {
            NSLog(@"\ndid selected index = %ld", (long)index);
        };
        advertisingView;
    })];
}

- (UIColor*)randomColor
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

- (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
