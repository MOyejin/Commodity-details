//
//  MXNavigationBarManager.h
//  MXBarManagerDemo
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 desn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MXNavigationBarManager : NSObject



@property (nonatomic, strong) UIColor *barColor; //NavigationBar 背景颜色，默认为白色

@property (nonatomic, strong) UIColor *tintColor; //NavigationBar subviews color
@property (nonatomic, strong) UIImage *backgroundImage; //default is nil
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle; // 默认是 UIStatusBarStyleDefault

@property (nonatomic, assign) float zeroAlphaOffset;//颜色会改变开始这个偏移量，默认值 -64
@property (nonatomic, assign) float fullAlphaOffset;//颜色alpha在这个偏移量中是1，默认是 200
@property (nonatomic, assign) float minAlphaValue;// 最小值  bar minAlpha, default is 0
@property (nonatomic, assign) float maxAlphaValue;//最大值  bar maxAlpha, default is 1

@property (nonatomic, strong) UIColor *fullAlphaTintColor;//如果你设置了这个属性，颜色会在fullalpha偏移中改变
@property (nonatomic, assign) UIStatusBarStyle fullAlphaBarStyle;//如果你设置了这个属性，barStyle会在fullalpha偏移中改变

@property (nonatomic, assign) BOOL allChange;//如果allchange=yes，颜色会随着颜色的改变而改变，默认是yes，如果你只想改变颜色，设置allchange=NO

@property (nonatomic, assign) BOOL reversal;//这将导致，如果currentAlpha=0.3，它将是1-0.3=0.7

@property (nonatomic, assign) BOOL continues;//当继续=YES时，当你滚动时，bar颜色会改变，如果你设置继续=NO，它只会在fullalpha偏移中改变


+ (void)setBarColor:(UIColor *)color;
+ (void)setTintColor:(UIColor *)color;
+ (void)setBackgroundImage:(UIImage *)image;
+ (void)setStatusBarStyle:(UIStatusBarStyle)style;

+ (void)setZeroAlphaOffset:(float)offset;
+ (void)setFullAlphaOffset:(float)offset;
+ (void)setMaxAlphaValue:(float)value;
+ (void)setMinAlphaValue:(float)value;

+ (void)setFullAlphaTintColor:(UIColor *)color;
+ (void)setFullAlphaBarStyle:(UIStatusBarStyle)style;

+ (void)setAllChange:(BOOL)allChange;
+ (void)setReversal:(BOOL)reversal;
+ (void)setContinues:(BOOL)continues;

+ (void)managerWithController:(UIViewController *)viewController;//您应该使用这个方法来init MXNavigationManager。

+ (void)changeAlphaWithCurrentOffset:(CGFloat)currentOffset;// 在@selec合计中实现这个方法(scrollView:scrollViewDidScroll)

+ (void)reStoreToSystemNavigationBar; //将导航条更改为系统样式

@end
