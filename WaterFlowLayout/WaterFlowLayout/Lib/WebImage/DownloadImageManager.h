//
//  DownloadImageManager.h
//  LoadWebImageTest
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageManager : NSObject
@property (nonatomic, strong)NSCache *imageCache;

+ (instancetype)sharedManager;

- (void)downloadImageOperationWithUrlString:(NSString *)urlString finishBlock:(void(^)(UIImage *))finishBlock;
- (void)cancelDownloadWithUrlString:(NSString *)urlString;
@end
