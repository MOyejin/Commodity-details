//
//  XYShopsBottomCell.h
//  掌上土地
//
//  Created by   on 17/6/9.
//  Copyright © 2017年 。. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYShopsBottomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sc_Button;
@property (nonatomic,copy) void(^shopBlcok)();

@property (nonatomic,copy) void (^XYShopsBottomCellBlock)(NSInteger teg);


@property (weak, nonatomic) IBOutlet UIButton *addButton; //加入购物车按钮
@property (weak, nonatomic) IBOutlet UIView *view_main; // 购物车背景View
@property (weak, nonatomic) IBOutlet UILabel *label_num; // 添加数量
@property (weak, nonatomic) IBOutlet UIView *view_num; //数量View


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bageView_width;




@end
