//
//  MOTableView.h
//  商品详情页
//
//  Created by 莫莫 on 2017/9/26.
//  Copyright © 2017年 MO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOTableView : UITableView

@property (nonatomic,copy) void (^MOTableViewBlock)(UIScrollView *scrollView);

@end
