//
//  UIBarButtonItem+Item.m

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (instancetype)rightItemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
}

+ (instancetype)rightItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;

}

+ (instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    btn.frame = CGRectMake(-25, 0, 70, 50);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title state:(NSUInteger)state target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:state];
    [btn sizeToFit];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
}

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    btn.frame = CGRectMake(-25, 0, 70, 50);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
}
@end
