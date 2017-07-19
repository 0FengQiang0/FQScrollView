//
//  FQImageView.m
//  ZZBJDemo
//
//  Created by 冯强 on 2017/6/22.
//  Copyright © 2017年 上海旻瑞信息技术有限公司. All rights reserved.
//

#import "FQImageView.h"

@implementation FQImageView

-(void)fq_setImageWithURL:(NSURL *)url {
    
    //创建网络请求配置类
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue new]];
    
    //创建请求并设置缓存策略以及超时时长
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30.f];
    
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //下载完成后获取数据，此时已经自动缓存到本地，下次会直接从本地缓存获取，不再进行网络请求
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //设置图片
            self.image = [UIImage imageWithData:data];
        });
        
    }];
    
    //启动下载任务
    [task resume];
    
}

@end
