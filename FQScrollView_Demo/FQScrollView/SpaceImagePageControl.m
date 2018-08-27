//
//  SpaceImagePageControl.m
//  Intelligence
//
//  Created by zxsd on 2018/8/23.
//  Copyright © 2018年 智行时代国际传媒（北京）有限公司. All rights reserved.
//

#import "SpaceImagePageControl.h"

@interface SpaceImagePageControl () {
    CGFloat _dotW;
    CGFloat _activeDotW;
    CGFloat _dotSpace;
}
@end

@implementation SpaceImagePageControl

-(instancetype)init {
    if (self = [super init]) {
        _dotW = 5;
        _activeDotW = 5;
        _dotSpace = 5;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = _dotW + _dotSpace;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX +_activeDotW;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.frame.size.width/2.0;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y - 0.5*(_activeDotW-_dotW), _activeDotW, _activeDotW)];
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius = 0.5*_activeDotW;
        }else {
            [dot setFrame:CGRectMake(0.5*(_activeDotW-_dotW)+ i * marginX, dot.frame.origin.y, _dotW, _dotW)];
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius = 0.5*_dotW;
        }
    }
}

-(void)setImage:(UIImage *)image {
    _image = image;
    [self setValue:_image forKeyPath:@"pageImage"];
}

-(void)setCurrentImage:(UIImage *)currentImage {
    _currentImage = currentImage;
    [self setValue:_currentImage forKeyPath:@"currentPageImage"];
}

-(void)setDotWidth:(CGFloat)width activeDotWidth:(CGFloat)activeWidth dotSpace:(CGFloat)space {
    _dotW = width;
    _activeDotW = activeWidth;
    _dotSpace = space;
    [self setNeedsLayout];
}

@end
