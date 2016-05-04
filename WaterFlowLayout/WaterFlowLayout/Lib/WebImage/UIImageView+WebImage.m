//
//  UIImageView+WebImage.m
//  LoadWebImageTest
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "DownloadImageManager.h"
#import <objc/runtime.h>
static void *kNameKey = "urlKey";

@implementation UIImageView (WebImage)
- (void)setImageWithUrlString:(NSString *)urlString{
    if (![self.currentUrl isEqualToString:urlString]){
        [[DownloadImageManager sharedManager] cancelDownloadWithUrlString:urlString];
        
        self.image = nil;
    }
    
    self.currentUrl = urlString;
    
    __weak typeof(self) weakSelf = self;
    
    [[DownloadImageManager sharedManager]downloadImageOperationWithUrlString:urlString finishBlock:^(UIImage *image) {
        weakSelf.image = image;
    }];

}

-(void)setCurrentUrl:(NSString *)currentUrl{
    objc_setAssociatedObject(self, kNameKey, currentUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)currentUrl{
    NSString *urlString = objc_getAssociatedObject(self, kNameKey);
    return urlString;
}
@end
