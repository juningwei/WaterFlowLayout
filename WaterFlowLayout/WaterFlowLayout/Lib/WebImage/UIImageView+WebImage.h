//
//  UIImageView+WebImage.h
//  LoadWebImageTest
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)
- (void)setImageWithUrlString:(NSString *)urlString;
@property (nonatomic, copy)NSString *currentUrl;
@end
