//
//  LYSPageMenuModel.h
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSPageMenuModel : NSObject

#pragma mark - 菜单图标
@property(nonatomic,copy)NSString *menuIcon;

#pragma mark - 菜单是否可用
@property(nonatomic,assign)BOOL enabled;

#pragma mark - 菜单排序
@property(nonatomic,assign)NSUInteger rank;

#pragma mark - 菜单标题
@property(nonatomic,copy)NSString *menuTitle;

@end
