//
//  UIBarButtonItem+Item.h

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)


// 设计方法
/** 选中按钮 右边*/
+ (instancetype)rightItemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
/** 高亮按钮 */
+ (instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/** 高亮按钮 右边*/
+ (instancetype)rightItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
/** 文字按钮 */

+ (instancetype)itemWithTitle:(NSString *)title state:(NSUInteger)state target:(id)target action:(SEL)action;
/** 选中按钮 */
+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

@end
;
