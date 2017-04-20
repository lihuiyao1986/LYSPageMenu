//
//  LYSPageMenuCell.h
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYSPageMenuModel.h"

@interface LYSPageMenuCell : UICollectionViewCell

@property(nonatomic,assign)NSUInteger row;

@property(nonatomic,assign)NSUInteger column;

@property(nonatomic,copy)NSArray<LYSPageMenuModel*>*item;

@property(nonatomic,copy)void(^ItemSelectedBlock)(LYSPageMenuModel* item);

@property(nonatomic,copy)void(^ImageLoader)(NSString *imageUrl,UIImageView *menuIcon);

@end
