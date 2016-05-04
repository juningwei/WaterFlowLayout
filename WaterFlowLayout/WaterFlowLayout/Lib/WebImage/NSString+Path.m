//
//  NSString+Path.m
//  LoadWebImage-Exam
//
//  Created by 鞠凝玮 on 16/1/24.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
- (NSString *)appendDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCachePath{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];

}

- (NSString *)appendTempPath{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
