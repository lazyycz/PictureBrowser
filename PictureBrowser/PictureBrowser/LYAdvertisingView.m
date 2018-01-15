//
//  LYAdvertisingView.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/15.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "LYAdvertisingView.h"
#import "LYAdvertisingCollectionViewFlowLaout.h"
#import "LYSampleCollectionViewCell.h"

@interface LYAdvertisingView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <UIImage *>*dataSource;

@end

@implementation LYAdvertisingView

static NSString *cellIdentifier = @"LYSampleCollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    [(LYSampleCollectionViewCell *)cell reloadCellWithImage:self.dataSource[indexPath.row]];
    self.pageControl.currentPage = indexPath.row;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    !self.didSelectPictureBrowserViewBlock ? : self.didSelectPictureBrowserViewBlock(self, [self.cellData[indexPath.row] integerValue]);
}

- (void)scrollToItemAtIndex:(NSInteger)indx animated:(BOOL)animated
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indx inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}


- (void)setDataSource:(NSArray<UIImage *> *)dataSource
{
    _dataSource = dataSource;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.dataSource.count;
    self.pageControl.currentPage = 0;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    return [LYAdvertisingCollectionViewFlowLaout new];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self flowLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LYSampleCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(5, self.bounds.size.height - 30, self.bounds.size.width - 10, 30)];
    }
    
    return _pageControl;
}

@end
