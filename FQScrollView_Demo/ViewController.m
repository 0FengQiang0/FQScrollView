//
//  ViewController.m
//  FQScrollView_Demo
//
//  Created by 冯强 on 2017/7/19.
//  Copyright © 2017年 上海旻瑞信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "FQAutoScrollView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化 .....
    FQAutoScrollView *scrollView = [[FQAutoScrollView alloc] initWithFrame:CGRectMake(20, 100,SCREEN_WIDTH-2*20, 120)];
    
    [self.view addSubview:scrollView];
    
    // 加载图片资源,可以是本地的,也可以是URL ...
    scrollView.imageArray = @[@"01.jpg",@"02.jpg",@"http://tva3.sinaimg.cn/crop.147.174.217.217.180/006prxrdjw8f2ywwpdmplj30aw0aw3yw.jpg"];
    
    // 因为数组里有以 http 开头的url，需要去 info.plist文件里做一下配置...否则无法显示网络图片 ...  加上  App Transport Security Settings
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
