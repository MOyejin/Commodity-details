//
//  BrandScrollerView.m
//  掌上土地
//
//  Created by 莫莫 on 2017/9/13.
//  Copyright © 2017年 。. All rights reserved.
//

#import "BrandScrollerView.h"
#define MaxZoomScale  2.5f
#define MinZoomScale  1.0f

@interface BrandScrollerView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation BrandScrollerView

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.userInteractionEnabled = YES;
        [_imgView setContentMode:UIViewContentModeScaleAspectFit];
        [_imgView setClipsToBounds:YES];
        
        UIImage *image_main = [UIImage imageNamed:@"brands"];
        
        CGFloat wind = [UIScreen mainScreen].bounds.size.width;
        CGFloat w = wind / 640;
        CGFloat h = image_main.size.height * w;
        
        _imgView.image = image_main;
        CGRect frame = self.bounds;
        frame.size = CGSizeMake(wind, h);
        _imgView.frame = frame;
        
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction)];
        [doubleTap setNumberOfTapsRequired:2];
        [_imgView addGestureRecognizer:doubleTap];
        
        [self addSubview:_imgView];
        
    }
    return _imgView;
}

#pragma mark 双击事件
- (void)doubleTapAction{//图片变大或变小
    if (self.minimumZoomScale <= self.zoomScale && self.maximumZoomScale > self.zoomScale) {
        [self setZoomScale:self.maximumZoomScale animated:YES];
    }else {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = NO;
        self.maximumZoomScale = MaxZoomScale;
        self.minimumZoomScale = MinZoomScale;
        self.imgView.backgroundColor = [UIColor whiteColor];
        self.contentSize = _imgView.bounds.size;
        
    }
    return self;
}

#pragma mark - Scroll View Deledate (不断适配图片大小)
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //放大或缩小时图片位置(frame)调整,保证居中
    CGFloat Wo = self.frame.size.width - self.contentInset.left - self.contentInset.right;
    CGFloat Ho = self.frame.size.height - self.contentInset.top - self.contentInset.bottom;
    CGFloat W = _imgView.frame.size.width;
    CGFloat H = _imgView.frame.size.height;
    CGRect rct = _imgView.frame;
    rct.origin.x = MAX((Wo-W)*0.5, 0);
    rct.origin.y = MAX((Ho-H)*0.5, 0);
    _imgView.frame = rct;
    NSLog(@"%@",NSStringFromCGRect( _imgView.frame));
}


@end
