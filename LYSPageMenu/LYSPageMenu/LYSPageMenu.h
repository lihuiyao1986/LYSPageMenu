//
//  LYSPageMenu.h
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSPageMenuModel.h"

@interface LYSPageMenu : UIView

@property(nonatomic,assign)CGFloat itemH;

@property(nonatomic,assign)CGFloat pageH;

@property(nonatomic,assign)NSUInteger row;

@property(nonatomic,assign)NSUInteger column;

@property(nonatomic,copy)NSArray<LYSPageMenuModel*> *items;

@property(nonatomic,assign)NSUInteger pages;

@property(nonatomic,strong)UIColor *selectedPageColor;

@property(nonatomic,strong)UIColor *normalPageColor;

@property(nonatomic,copy)void(^ItemSelectedBlock)(LYSPageMenuModel* item);

@property(nonatomic,copy)void(^ImageLoader)(NSString *imageUrl,UIImageView *menuIcon);

@end
