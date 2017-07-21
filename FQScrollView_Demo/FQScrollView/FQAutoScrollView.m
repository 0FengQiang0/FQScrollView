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

-(void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    _FRAME = frame;
    _scrollView.frame = CGRectMake(0, 0, _FRAME.size.width, _FRAME.size.height);
    _pageControl.frame = CGRectMake(0, _FRAME.size.height*3/4.0, _FRAME.size.width, _FRAME.size.height/4.0);
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
        _pageControl.numberOfPages = _imageArray.count;
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
        _scrollView.contentOffset = CGPointMake(_imageArray.count*_FRAME.size.width, 0);
    if (_scrollView.contentOffset.x == (_imageArray.count +1)*_FRAME.size.width)
        _scrollView.contentOffset = CGPointMake(_FRAME.size.width, 0);
    
    _pageControl.currentPage = (_scrollView.contentOffset.x +_scrollView.frame.size.width*0.5)/_scrollView.frame.size.width -1;
}

-(void)viewAutoScroll {
    
    CGPoint tmpPoint = _scrollView.contentOffset;
    tmpPoint.x += _FRAME.size.width;
    [_scrollView setContentOffset:tmpPoint animated:YES];
}

-(void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    
    if (_FRAME.size.width != 0 || _FRAME.size.height != 0)
        [self loadImage];
}

- (void)loadImage {
    
    _pageControl.numberOfPages = _imageArray.count;
    _scrollView.contentSize = CGSizeMake((_imageArray.count +2)*_FRAME.size.width, 0);
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<_imageArray.count +2; i++) {
        
        FQImageView *imageView = [[FQImageView alloc] initWithFrame:CGRectMake(i*_FRAME.size.width, 0, _FRAME.size.width, _FRAME.size.height)];
        
        if (i == 0 && _imageArray.count!=0){
            if ([_imageArray[_imageArray.count-1] containsString:@"http"]||[_imageArray[_imageArray.count-1] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_imageArray[_imageArray.count-1]]];
            else
                imageView.image = [UIImage imageNamed:_imageArray[_imageArray.count-1]];
        }
        
        if (i > 0 && i<_imageArray.count +1){
            if ([_imageArray[i-1] containsString:@"http"]||[_imageArray[i-1] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_imageArray[i-1]]];
            else
                imageView.image = [UIImage imageNamed:_imageArray[i-1]];
        }
        
        if (i == _imageArray.count +1 && _imageArray.count!=0){
            if ([_imageArray[0] containsString:@"http"]||[_imageArray[0] containsString:@"https"])
                [imageView fq_setImageWithURL:[NSURL URLWithString:_imageArray[0]]];
            else
                imageView.image = [UIImage imageNamed:_imageArray[0]];
        }
        
        [_scrollView addSubview:imageView];
        
    }
}

@end
