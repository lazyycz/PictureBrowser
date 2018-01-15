//
//  LYPictureBrowserView.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/13.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "LYPictureBrowserView.h"
#import "LYSampleCollectionViewCell.h"

const NSUInteger kCellGroupCount = 100;

@interface LYPictureBrowserView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <UIImage *>*dataSource;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*cellData;
@property (nonatomic, assign) NSInteger dataSourceCount;

@property (nonatomic, assign) NSTimeInterval duringTime;
@property (strong, nonatomic) NSTimer *timer;

@end


@implementation LYPictureBrowserView

static NSString *cellIdentifier = @"LYSampleCollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame intervalTime:(NSTimeInterval)duringTime
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        
        _duringTime = duringTime;
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    NSInteger index = [self.cellData[indexPath.row] integerValue];
    [(LYSampleCollectionViewCell *)cell reloadCellWithImage:self.dataSource[index]];
    self.pageControl.currentPage = index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int inc = ((int)(scrollView.contentOffset.x / scrollView.frame.size.width)) % self.dataSourceCount;
    [self scrollToItemAtIndex:self.cellData.count / 2 + inc animated:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelectPictureBrowserViewBlock ? : self.didSelectPictureBrowserViewBlock(self, [self.cellData[indexPath.row] integerValue]);
}

- (void)scrollToItemAtIndex:(NSInteger)indx animated:(BOOL)animated
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indx inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}


- (void)setDataSource:(NSArray<UIImage *> *)dataSource
{
    _dataSource = dataSource;
    self.dataSourceCount = _dataSource.count;
    
    self.cellData = [NSMutableArray array];
    for (int i=0; i<kCellGroupCount; i++) {
        for (int j=0; j<self.dataSourceCount; j++) {
            [self.cellData addObject:@(j)];
        }
    }

    [self.collectionView reloadData];
    [self scrollToItemAtIndex:self.cellData.count / 2 animated:NO];
    
    self.pageControl.numberOfPages = self.dataSourceCount;
    self.pageControl.currentPage = 0;
    
    if (self.duringTime > 0) {
        [self openTimer];
    }
}

- (void)closeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)openTimer
{
    [self closeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duringTime target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)onTimer
{
    if (self.cellData.count > 0) {
        NSArray *array = [self.collectionView indexPathsForVisibleItems];
        if (array.count == 0) return ;
        
        NSIndexPath *indexPath = array[0];
        NSInteger row = indexPath.row;
        
        if (row % self.dataSourceCount == 0) {
            row = self.cellData.count / 2;         // 重新定位
            [self scrollToItemAtIndex:row animated:NO];
        }
        [self scrollToItemAtIndex:row + 1 animated:YES];
        self.pageControl.currentPage = (row + 1) % self.dataSourceCount;
    }
}

- (UICollectionViewFlowLayout *)flowLayout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return flowLayout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self flowLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
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
