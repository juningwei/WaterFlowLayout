//
//  WaterFlowLayout.m
//  WaterFlowLayout
//
//  Created by 鞠凝玮 on 16/2/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "WaterFlowLayout.h"
static const NSInteger DefaultColumnCount = 3;

static const CGFloat DefaultColumnMargin = 10;
static const CGFloat DefaultRowMargin = 10;
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterFlowLayout ()
@property (nonatomic, strong)NSMutableArray *attrsArray;
@property (nonatomic, strong)NSMutableArray *columnHeights;
@property (nonatomic, assign)CGFloat contentHeight;
-(CGFloat)columnCount;
-(CGFloat)columnMargin;
-(CGFloat)rowMargin;
-(UIEdgeInsets)edgeInsets;

@end

@implementation WaterFlowLayout

-(CGFloat)columnCount{
    if ([self.delegate respondsToSelector:@selector(ColumnCountInWaterFlowLayout:)]){
        return [self.delegate ColumnCountInWaterFlowLayout:self];
    }
    return DefaultColumnCount;

}

-(CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(ColumnMarginInWaterFlowLayout:)]){
        return [self.delegate ColumnMarginInWaterFlowLayout:self];
    }
    return DefaultColumnMargin;
}

-(UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(EdgeInsetsInWaterFlowLayout:)]){
        return [self.delegate EdgeInsetsInWaterFlowLayout:self];
    }
    return DefaultEdgeInsets;

}

-(CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(RowMarginInWaterFlowLayout:)]){
        return [self.delegate RowMarginInWaterFlowLayout:self];
    }
    return DefaultRowMargin;
}

-(NSMutableArray *)columnHeights{
    if (!_columnHeights){
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)attrsArray{
    if (!_attrsArray){
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout{
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    for (int i=0;i<self.columnCount;i++){
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0;i<count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = CGRectGetWidth(self.collectionView.frame);
    CGFloat w = (collectionViewW-self.edgeInsets.left-self.edgeInsets.right-(self.columnCount-1)*self.columnMargin)/self.columnCount;
    
    
    CGFloat h = [self.delegate WaterFlowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    NSInteger destColumn = 0;
//    __block CGFloat minColumnHeight = 0;
//    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat columnHeight = columnHeightNumber.doubleValue;
//        if (columnHeight < minColumnHeight){
//            minColumnHeight = columnHeight;
//            destColumn = idx;
//        }
//    }];
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i=0;i<self.columnCount;i++){
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight){
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = self.edgeInsets.left+destColumn*(w+self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y!=self.edgeInsets.top){
        y+=self.rowMargin;
    }

    attrs.frame = CGRectMake(x, y, w, h);
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame)) ;
    return attrs;
}

-(CGSize)collectionViewContentSize{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i=0;i<self.columnCount;i++){
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight){
            maxColumnHeight = columnHeight;
        }
    }
    
    return CGSizeMake(0, maxColumnHeight+self.edgeInsets.bottom);
}

@end
