//
//  XYShopsBottomCell.m
//  掌上土地
//
//  Created by   on 17/6/9.
//  Copyright © 2017年 。. All rights reserved.
//

#import "XYShopsBottomCell.h"

#define MOScreenW   [UIScreen mainScreen].bounds.size.width

@interface XYShopsBottomCell()

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icon_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTwo_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTwo_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconThree_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconThree_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTwo_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconThree_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_bottom;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_height;




@end

@implementation XYShopsBottomCell

- (IBAction)ShopsButton:(id)sender {
    
    if (_shopBlcok) {
        _shopBlcok();
    }
    
}
- (IBAction)button_All:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    if (sender.tag == 2) {
   
        if (self.sc_Button.selected) {
            
            tag = 1000;
        }
        self.sc_Button.selected = !self.sc_Button.isSelected;
        
    }
    
    if (self.XYShopsBottomCellBlock) {
        self.XYShopsBottomCellBlock(tag);
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.view_num.hidden = YES;
    self.view_main.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:0.8];
   
    
    
    
    CGFloat font = 11;
    CGFloat fontTwo = 15;
    
    CGFloat moTimes = 1.2;
    
    if (MOScreenW < 414) {
        
        self.icon_width.constant /= moTimes;
        self.icon_height.constant /= moTimes;
        self.iconTwo_width.constant /= moTimes;
        self.iconTwo_height.constant /= moTimes;
        self.iconThree_width.constant /= moTimes;
        self.iconThree_height.constant /= moTimes;
        self.icon_top.constant /= moTimes;
        self.icon_top.constant -= 2;
        self.iconTwo_top.constant /= moTimes;
        self.iconTwo_top.constant -= 2;
        self.iconThree_top.constant /= moTimes;
        self.iconThree_top.constant -= 2;
        self.view_bottom.constant /= moTimes;
        self.view_width.constant /= moTimes;
        self.view_height.constant /= moTimes;
        self.image_width.constant /= moTimes;
        self.image_height.constant /= moTimes;
        font /= moTimes;
        fontTwo /= moTimes;
    }
    
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:fontTwo];
    self.sc_Button.titleLabel.font = [UIFont systemFontOfSize:font];
    self.twoButton.titleLabel.font = [UIFont systemFontOfSize:font];
    self.oneButton.titleLabel.font = [UIFont systemFontOfSize:font];
    
    [self.view_main.layer setCornerRadius:self.view_width.constant * 0.5];
    
}
- (void)teg{
    
    self.sc_Button.selected = !self.sc_Button.isSelected;
    
}

@end
