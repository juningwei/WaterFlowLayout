//
//  DownloadImageOperation.h
//  CustomOperation
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadImageOperation : NSOperation
@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, copy)void (^finishBlock)(UIImage *image);
+ (instancetype)downloadImageOperationWithUrlString:(NSString *)urlString finishBlock:(void(^)(UIImage *))finishBlock;
@end
