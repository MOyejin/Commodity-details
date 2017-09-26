//
//  MOTableView.m
//  商品详情页
//
//  Created by 莫莫 on 2017/9/26.
//  Copyright © 2017年 MO. All rights reserved.
//

#import "MOTableView.h"
#import <SDCycleScrollView.h>
#import "UIView+Extension.h"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define MOScreenW   [UIScreen mainScreen].bounds.size.width
#define MOScreenH  [UIScreen mainScreen].bounds.size.height-StatusBarHeight

@interface MOTableView()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,weak)SDCycleScrollView *scrollView;

@property (nonatomic,assign)CGFloat height_h;//头部视图的高度

@property (nonatomic, assign)CGRect imgRect;

@property (nonatomic, assign)CGFloat previousY;

@end

@implementation MOTableView

- (void)addSDVc{
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -self.height_h ,MOScreenW, self.height_h) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    self.scrollView = cycleScrollView;
    cycleScrollView.backgroundColor = [UIColor clearColor];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.pageControlDotSize = CGSizeMake(18, 18.f);
    cycleScrollView.currentPageDotColor = [UIColor greenColor];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
//    cycleScrollView.localizationImageNamesGroup = @[@"0081"];
    cycleScrollView.imageURLStringsGroup = @[@"http://image.xcar.com.cn/attachments/a/day_141212/2014121222_d6745bedf3188ee53ecf6U6nOeXHTB14.gif",@"http://s14.sinaimg.cn/mw690/bf156d1atd757387fe71d&690",@"http://s8.rr.itc.cn/g/wapChange/20156_20_7/a2ps764138673752519.gif",@"http://easyread.ph.126.net/71doSeF5SmIuv0TLhfQVFQ==/6597071965682028901.gif",@"http://s9.rr.itc.cn/g/wapChange/20159_15_7/a5xui21160319620352.gif",@"http://s7.rr.itc.cn/g/wapChange/20159_14_10/a9wtk16129501088352.gif"];
    
    [self insertSubview:cycleScrollView atIndex:0];
    self.previousY = -cycleScrollView.size.height;
    self.imgRect = cycleScrollView.frame;
    
    cycleScrollView.autoScroll = NO;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.contentInset = UIEdgeInsetsMake(cycleScrollView.height, 0, 0, 0);
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.height_h = 330;
        
        if (MOScreenW < 414) {
            
            self.height_h = 250;
        }
        
        self.backgroundColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1.0];
        self.showsVerticalScrollIndicator = NO;
        self.rowHeight = 40;
        self.delegate = self;
        self.dataSource = self;
        [self addSDVc];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.MOTableViewBlock) {
        self.MOTableViewBlock(scrollView);
    }
    
    // 往上下滚动
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY > self.imgRect.origin.y && contentOffsetY<0) {
        if (self.scrollView.height > self.imgRect.size.height) {
            self.scrollView.y = - self.imgRect.size.height;
            self.scrollView.height = self.imgRect.size.height;
            self.previousY = -self.imgRect.size.height ;
        }
        self.scrollView.y += (contentOffsetY - self.previousY) * 0.5;
        self.previousY = contentOffsetY;
        return;
    }else  if(contentOffsetY <= -self.imgRect.size.height){
        
        if (self.scrollView.y > - self.imgRect.size.height) {
            self.scrollView.y =  - self.imgRect.size.height;
            
            self.previousY = -self.imgRect.size.height;
        }
        CGFloat sss = (self.previousY - contentOffsetY);
        self.scrollView.y  -= sss;
        self.scrollView.height +=  sss ;
        NSLog(@"%f -- %f", self.scrollView.height, self.scrollView.width);
        self.previousY = contentOffsetY;
    }
  
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *key = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



@end
