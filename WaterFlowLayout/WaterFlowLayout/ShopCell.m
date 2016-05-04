//
//  ShopCell.m
//  WaterFlowLayout
//
//  Created by 鞠凝玮 on 16/2/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "ShopCell.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+WebImage.h"
#import "Shop.h"
@interface ShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation ShopCell

-(void)setShop:(Shop *)shop{
    _shop = shop;
    [self.shopImageView setImageWithUrlString:shop.img];
//    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:nil];
    self.priceLabel.text = shop.price;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
