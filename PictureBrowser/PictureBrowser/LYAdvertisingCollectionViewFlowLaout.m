//
//  LYAdvertisingCollectionViewFlowLaout.m
//  PictureBrowser
//
//  Created by Stone.Yu on 2018/1/15.
//  Copyright © 2018年 Stone.Yu. All rights reserved.
//

#import "LYAdvertisingCollectionViewFlowLaout.h"

@implementation LYAdvertisingCollectionViewFlowLaout

-(void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat width = self.collectionView.frame.size.width * 0.7;
    CGFloat height = self.collectionView.frame.size.height * 0.7;
    self.itemSize = CGSizeMake(width, height);
    self.minimumLineSpacing = 15;
    self.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray * attributes =  [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    for (UICollectionViewLayoutAttributes * attri in attributes) {
        CGFloat delat = ABS(attri.center.x - centerX);
        CGFloat scales = 1 - delat / (self.collectionView.bounds.size.width) * 0.2;
        attri.transform = CGAffineTransformMakeScale(scales, scales);
    }
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    NSArray * attributes = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    CGFloat minDetal =  MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attrs in attributes) {
        if (ABS(minDetal) > ABS(attrs.center.x - centerX)) {
            minDetal = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minDetal, proposedContentOffset.y);
}

@end
