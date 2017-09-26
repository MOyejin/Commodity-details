//
//  MOViewController.m
//  商品详情页 (图片下拉放大,tableView上下分页效果)
//
//  Created by 莫莫 on 2017/9/25.
//  Copyright © 2017年 MO. All rights reserved.
//

#import "MOViewController.h"
#import <MJRefresh.h>
#import "UIView+Extension.h"
#import "MXNavigationBarManager.h"
#import "UIBarButtonItem+Item.h"
#import "BrandScrollerView.h"
#import "MOTableView.h"
#import "XYShopsBottomCell.h"
#import <StoreKit/StoreKit.h>
#import <UIImageView+WebCache.h>

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define MOScreenW   [UIScreen mainScreen].bounds.size.width
#define MOScreenH  [UIScreen mainScreen].bounds.size.height-StatusBarHeight
#define mogreenColor [UIColor colorWithRed:71/255.0 green:198/255.0 blue:102/255.0 alpha:1] //绿色

@interface MOViewController ()<SKStoreProductViewControllerDelegate,CAAnimationDelegate>
{
    CALayer     *layer;
    NSInteger    _cnt;
    BOOL   click; // 判断购物车添加状态
}
@property (nonatomic,strong) UIBezierPath *path;//抛物线动画
@property (nonatomic,assign)CGFloat width_bage;//保存当前bage的宽度


@property (strong, nonatomic) MOTableView *tableView_main;

@property (nonatomic,strong) UITableView *image_tabelView;

@property (nonatomic,assign)CGFloat scrollView_y;//记录当前滑动的Y值

@property (nonatomic,strong)BrandScrollerView *scrollView_main;

@property (nonatomic,strong) XYShopsBottomCell *cell;//底部栏View

@property (nonatomic,assign)CGFloat cell_height;//底部栏的高度

@end

@implementation MOViewController

-(void)startAnimation
{
    __weak typeof(self) weakSelf = self;

    if (!layer) {
        weakSelf.cell.addButton.enabled = NO;
        
        layer = [CALayer layer];
        
        UIImageView *view = [UIImageView new];
        [view sd_setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/3801213fb80e7becd99bdf20262eb9389a506baa.jpg"]];

        layer.contents = (__bridge id)view.image.CGImage;
        
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 25, 25);// 抛出去物品的位置和大小
        [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2]; // 设置形状
        layer.masksToBounds = YES;
        layer.position =CGPointMake(50, 150);
        [weakSelf.view.layer addSublayer:layer];
    }
    [weakSelf groupAnimation];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

    if (anim == [layer animationForKey:@"group"]) {
        
        self.cell.view_num.hidden = NO;
        self.cell.view_main.backgroundColor = mogreenColor;
        self.cell.addButton.enabled = YES;
        [layer removeFromSuperlayer];
        layer = nil;
        
        ++_cnt;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        
        if (_cnt >= 100) {
            
            self.cell.bageView_width.constant = self.width_bage + 10;
        }
        
        self.cell.label_num.text = [NSString stringWithFormat:@"%ld",_cnt];
        [self.cell.label_num.layer addAnimation:animation forKey:nil];
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"]; // 抖动动画
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [self.cell.view_main.layer addAnimation:shakeAnimation forKey:nil];
        
        self.cell.addButton.userInteractionEnabled = YES;
        
    }
}


-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = 0.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = .5f; // 抛物速度
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeBoth;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
}


#pragma mark - 创建底部栏
- (void)initBottom {
    
    __weak typeof(self) weakSelf = self;
    
    XYShopsBottomCell * cell = [[NSBundle mainBundle]loadNibNamed:@"XYShopsBottomCell" owner:nil options:nil].lastObject;
    
    cell.frame = CGRectMake(0, MOScreenH - weakSelf.cell_height, MOScreenW, weakSelf.cell_height);
    
    weakSelf.cell = cell;
    weakSelf.width_bage = cell.bageView_width.constant;
    
    __weak typeof(XYShopsBottomCell *)weakcell = cell;
    
    cell.shopBlcok = ^{
        
        weakcell.addButton.userInteractionEnabled = NO;
        [weakSelf startAnimation];
        
    };
    
    cell.XYShopsBottomCellBlock = ^(NSInteger teg) {
        
        NSLog(@"%ld",teg);
        
    };
    
    [self.view addSubview:cell];
    
    
    
}

//MARK: 添加上下翻页功能
- (void)setHeadandFoot{
    
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            weakSelf.tableView_main.frame = CGRectMake(0, -MOScreenH, MOScreenW, MOScreenH - weakSelf.cell_height);
            weakSelf.scrollView_main.frame = CGRectMake(0, 64, MOScreenW, MOScreenH - 64 - weakSelf.cell_height);
            
        } completion:^(BOOL finished) {
            //结束加载
            [weakSelf.tableView_main.mj_footer endRefreshing];
            
        }];
        
    }];
    self.tableView_main.mj_footer = footer;
    footer.triggerAutomaticallyRefreshPercent = 15.0;
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            weakSelf.scrollView_main.frame = CGRectMake(0, MOScreenH, MOScreenW, 0);
            weakSelf.tableView_main.frame = CGRectMake(0, 0, MOScreenW, MOScreenH - weakSelf.cell_height);
            
            
        } completion:^(BOOL finished) {
            //结束加载
            [weakSelf.scrollView_main.mj_header endRefreshing];
            
        }];
        
    }];
    self.scrollView_main.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.arrowView.image = [UIImage imageNamed:@""];
    [header setTitle:@"下拉，返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回宝贝详情" forState:MJRefreshStatePulling];

    
}
- (void)initBarManager {
    
    
    [MXNavigationBarManager managerWithController:self];
    [MXNavigationBarManager setBarColor:[UIColor whiteColor]];
    
    CGFloat alpha = 0;
    
    if (self.scrollView_y > -64) { // 判断滑动的Y值
        
        alpha = 1;
    }
    [MXNavigationBarManager setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:alpha]];
    
    [MXNavigationBarManager setTintColor:[UIColor blackColor]];
    [MXNavigationBarManager setStatusBarStyle:UIStatusBarStyleDefault];
    [MXNavigationBarManager setZeroAlphaOffset:-228];//颜色会改变开始这个偏移量
    [MXNavigationBarManager setFullAlphaOffset:-64];//颜色alpha在这个偏移量中是1
    [MXNavigationBarManager setFullAlphaTintColor:[UIColor blackColor]];
    [MXNavigationBarManager setFullAlphaBarStyle:UIStatusBarStyleLightContent];
    
    [MXNavigationBarManager changeAlphaWithCurrentOffset:self.scrollView_y];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [MXNavigationBarManager reStoreToSystemNavigationBar]; //恢复原来的NavController
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initBarManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat cell_height = 45;
    if (MOScreenW < 414) {

        cell_height /= 1.2;
        
    }
    self.cell_height = cell_height;
    
    [self.view addSubview:self.tableView_main];
    [self.view addSubview:self.scrollView_main];
    
    [self setHeadandFoot];
    [self initBottom];

     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"left_white"] highImage:[UIImage imageNamed:@"left_white"] target:self action:@selector(popBtn)];
    
    
    
    //抛物线初始化
    self.path = [UIBezierPath bezierPath];
    //    [_path moveToPoint:CGPointMake(50, 150)];
    [_path moveToPoint:CGPointMake(MOScreenW - 15, MOScreenH - 45)]; // 设置抛物线的起点
    [_path addQuadCurveToPoint:CGPointMake(50, MOScreenH - 45) controlPoint:CGPointMake((MOScreenW - 50) * 0.5, (MOScreenH - 128) * 0.9 )];//设置抛物线的终点 和最高点
    
}
- (void)popBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.tableView_main.frame.origin.y == 0) { //是详情的控制器才下拉放大
        
        self.scrollView_y = scrollView.contentOffset.y;
        
        NSLog(@"偏移量: %f",scrollView.contentOffset.y);
        [MXNavigationBarManager changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
    }
    
}



- (MOTableView *)tableView_main{
    if (!_tableView_main) {
        _tableView_main = [[MOTableView alloc] initWithFrame:CGRectMake(0, 0, MOScreenW, MOScreenH - self.cell_height) style:UITableViewStyleGrouped];
        __weak typeof(self) weakSelf = self;
        _tableView_main.MOTableViewBlock = ^(UIScrollView *scrollView) {

            [weakSelf scrollViewDidScroll:scrollView];
        };
    }
    return _tableView_main;
}


- (BrandScrollerView *)scrollView_main{
    if (!_scrollView_main) {
        _scrollView_main = [[BrandScrollerView alloc] initWithFrame:CGRectMake(0, MOScreenH - 64, MOScreenW, 0)];
        _scrollView_main.showsVerticalScrollIndicator = NO;
    }
    return _scrollView_main;
}

@end
