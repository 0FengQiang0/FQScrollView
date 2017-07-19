//
//  FQAutoScrollView.m
//  ZZBJDemo
//
//  Created by 冯强 on 2017/6/22.
//  Copyright © 2017年 上海旻瑞信息技术有限公司. All rights reserved.
//

#import "FQAutoScrollView.h"
#import "FQImageView.h"

@interface FQAutoScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGRect FRAME;

@end

@implementation FQAutoScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        _FRAME = frame;
        [self prepareUI];
    }
    
    return self;
}

-(void)prepareUI {
    
    [self addSubview:self.scrollView];
    [self insertSubview:self.pageControl aboveSubview:_scrollView];
    [self.timer setFireDate:[NSDate distantPast]];
}

-(UIScrollView*)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _FRAME.size.width, _FRAME.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

-(UIPageControl*)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _FRAME.size.height*3/4.0, _FRAME.size.width, _FRAME.size.height/4.0)];
        _pageControl.numberOfPages = _dataArray.count;
        _pageControl.enabled = NO;
    }
    
    return _pageControl;
}

-(NSTimer*)timer {
    
    if (!_timer)
        // 创建一个定时器...
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(viewAutoScroll) userInfo:nil repeats:YES];
    return _timer;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_scrollView.contentOffset.x == 0)
        _scrollView.contentOffset = CGPointMake(_dataArray.count*_FRAME.size.width, 0);
    if (_scrollView.contentOffset.x == (_dataArray.count +1)*_FRAME.size.width)
        _scrollView.contentOffset = CGPointMake(_FRAME.size.width, 0);
    
    _pageControl.currentPage = (_scrollView.contentOffset.x +_scrollView.frame.size.width*0.5)/_scrollView.frame.size.width -1;
}

-(void)viewAutoScroll {
    
    CGPoint tmpPoint = _scrollView.contentOffset;
    tmpPoint.x += _FRAME.size.width;
    [_scrollView setContentOffset:tmpPoint animated:YES];
}

-(void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    _scrollView.contentSize = CGSizeMake((_dataArray.count +2)*_FRAME.size.width, 0);
    _pageControl.numberOfPages = _dataArray.count;
    
    
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<_dataArray.count +2; i++) {
        
        FQImageView *imageView = [[FQImageView alloc] initWithFrame:CGRectMake(i*_FRAME.size.width, 0, _FRAME.size.width, _FRAME.size.height)];
        
        if (i == 0 && _dataArray.count!=0){
            if ([_dataArray[_dataArray.count-1] containsString:@"http"]||[_dataArray[_dataArray.count-1] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_dataArray[_dataArray.count-1]]];
            else
                imageView.image = [UIImage imageNamed:_dataArray[_dataArray.count-1]];
        }
        
        if (i > 0 && i<_dataArray.count +1){
            if ([_dataArray[i-1] containsString:@"http"]||[_dataArray[i-1] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_dataArray[i-1]]];
            else
                imageView.image = [UIImage imageNamed:_dataArray[i-1]];
        }
        
        if (i == _dataArray.count +1 && _dataArray.count!=0){
            if ([_dataArray[0] containsString:@"http"]||[_dataArray[0] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_dataArray[0]]];
            else
                imageView.image = [UIImage imageNamed:_dataArray[0]];
        }
        
        [_scrollView addSubview:imageView];
        
    }

}

@end
