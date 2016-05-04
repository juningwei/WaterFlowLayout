//
//  DownloadImageOperation.m
//  CustomOperation
//
//  Created by 鞠凝玮 on 16/1/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "DownloadImageOperation.h"
#import "NSString+Path.h"
@implementation DownloadImageOperation

+ (instancetype)downloadImageOperationWithUrlString:(NSString *)urlString finishBlock:(void(^)(UIImage *))finishBlock{
    DownloadImageOperation *operation = [[self alloc]init];
    operation.urlString = urlString;
    operation.finishBlock = finishBlock;
    return operation;
}

-(void)main{
    @autoreleasepool {
        NSAssert(self.finishBlock != nil, @"finishBlock不能为空!");
//        NSLog(@"耗时操作===%@",[NSThread currentThread]);
        NSLog(@"正在下载%@",self.urlString);

        [NSThread sleepForTimeInterval:2];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
        if (self.cancelled){
            NSLog(@"%@操作被取消",self.urlString);
            return;
        }
        if (data){
            [data writeToFile:self.urlString.appendCachePath atomically:YES];
        }
//        self.
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.finishBlock([UIImage imageWithData:data]);
        }];
    }
}

//-(void)start{
//    NSLog(@"%s",__func__);
//    [super start];
//}
@end
