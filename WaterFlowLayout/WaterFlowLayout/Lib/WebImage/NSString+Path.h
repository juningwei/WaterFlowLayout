//
//  NSString+Path.h
//  LoadWebImage-Exam
//
//  Created by 鞠凝玮 on 16/1/24.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
- (NSString *)appendDocumentPath;
- (NSString *)appendCachePath;
- (NSString *)appendTempPath;

@end
