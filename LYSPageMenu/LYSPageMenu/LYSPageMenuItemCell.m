//
//  LYSPageMenuItemCell.m
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPageMenuItemCell.h"


@interface LYSPageMenuItemCell ()

@property(nonatomic,strong)UIImageView *menuIcon;

@property(nonatomic,strong)UILabel *menuTitle;

@end

@implementation LYSPageMenuItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(UIImageView*)menuIcon{
    if (!_menuIcon) {
        _menuIcon = [UIImageView new];
        _menuIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _menuIcon;
}

-(UILabel*)menuTitle{
    if (!_menuTitle) {
        _menuTitle = [UILabel new];
        _menuTitle.textColor = [self colorWithHexString:@"414141" alpha:1.0];
        _menuTitle.textAlignment = NSTextAlignmentCenter;
        _menuTitle.numberOfLines = 1;
        _menuTitle.font = [UIFont systemFontOfSize:14];
        _menuTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _menuTitle;
}

#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 初始化方法
-(void)initConfig{
    [self.contentView addSubview:self.menuTitle];
    [self.contentView addSubview:self.menuIcon];
}

#pragma mark - 设置数据
-(void)setItem:(LYSPageMenuModel *)item{
    _item = item;
    self.menuTitle.text = item.menuTitle;
    if (self.ImageLoader) {
        self.ImageLoader(item.menuIcon,self.menuIcon);
    }
}

#pragma mark - 初始化方法
-(void)layoutSubviews{
    [super layoutSubviews];
    self.menuIcon.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.7);
    self.menuTitle.frame = CGRectMake(5, CGRectGetMaxY(self.menuIcon.frame), self.frame.size.width - 10, 20);
}

@end
