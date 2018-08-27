//
//  SpaceImagePageControl.h
//  Intelligence
//
//  Created by zxsd on 2018/8/23.
//  Copyright © 2018年 智行时代国际传媒（北京）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpaceImagePageControl : UIPageControl

@property(nonatomic,strong)UIImage* image;
@property(nonatomic,strong)UIImage* currentImage;

-(void)setDotWidth:(CGFloat)width activeDotWidth:(CGFloat)activeWidth dotSpace:(CGFloat)space;

@end
