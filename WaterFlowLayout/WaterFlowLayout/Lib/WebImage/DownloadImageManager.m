//
//  DownloadImageManager.m
//  LoadWebImageTest
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "DownloadImageManager.h"
#import "DownloadImageOperation.h"
#import "NSString+Path.h"
@interface DownloadImageManager ()
@property (nonatomic, strong)NSOperationQueue *operationQueue;
@property (nonatomic, strong)NSMutableDictionary *operationCache;
@end

@implementation DownloadImageManager

-(NSOperationQueue *)operationQueue{
    if (!_operationQueue){
        _operationQueue = [[NSOperationQueue alloc]init];
    }
    return _operationQueue;
}

-(NSMutableDictionary *)operationCache{
    if (!_operationCache){
        _operationCache = [NSMutableDictionary new];
    }
    return _operationCache;
}

-(NSCache *)imageCache{
    if (!_imageCache){
        _imageCache = [NSCache new];
//        _imageCache.countLimit = ;
        _imageCache.totalCostLimit = 10;
    }
    return _imageCache;
}

+ (instancetype)sharedManager{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clearMemory{
    [self.operationQueue cancelAllOperations];
    
    [self.operationCache removeAllObjects];
//    [self.imageCache removeAllObjects];
//    NSArray *key = self.imageCache
//    NSLog(@"imageCache==%@",self.imageCache);
}

- (void)downloadImageOperationWithUrlString:(NSString *)urlString finishBlock:(void(^)(UIImage *))finishBlock{
    if (self.operationCache[urlString] != nil){
        NSLog(@"正在玩命下载中...请稍后");
        return;
    }
    
    if ([self checkImageCache:urlString]){
        UIImage *image = [self.imageCache objectForKey:urlString];
        finishBlock(image);
        return;
    }

    
    DownloadImageOperation *operation = [DownloadImageOperation downloadImageOperationWithUrlString:urlString finishBlock:^(UIImage *image) {
        
        finishBlock(image);
        [self.operationCache removeObjectForKey:urlString];
        
    }];
    
    [self.operationCache setObject:operation forKey:urlString];
    [self.operationQueue addOperation:operation];
}

- (void)cancelDownloadWithUrlString:(NSString *)urlString{
    DownloadImageOperation *operation = self.operationCache[urlString];
    if (operation == nil){
        return;
    }
    
    [operation cancel];
    [self.operationCache removeObjectForKey:urlString];
}

- (BOOL)checkImageCache:(NSString *)urlString{
    if ([self.imageCache objectForKey:urlString]){
        NSLog(@"内存缓存");
        return YES;
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:urlString.appendCachePath];
    if (image){
        NSLog(@"沙盒缓存");
        [self.imageCache setObject:image forKey:urlString];
        return YES;
    }
    return NO;
}
@end
