//
//  WaterFlowLayout.h
//  WaterFlowLayout
//
//  Created by 鞠凝玮 on 16/2/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;
@protocol WaterFlowDelegate <NSObject>
@required
-(CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
- (CGFloat)ColumnCountInWaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout;
- (CGFloat)ColumnMarginInWaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout;
- (CGFloat)RowMarginInWaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout;
- (UIEdgeInsets)EdgeInsetsInWaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout;

@end


@interface WaterFlowLayout : UICollectionViewLayout
@property (nonatomic, weak)id<WaterFlowDelegate>delegate;
@end
