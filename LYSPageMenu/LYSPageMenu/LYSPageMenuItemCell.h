//
//  LYSPageMenuItemCell.h
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSPageMenuModel.h"

@interface LYSPageMenuItemCell : UICollectionViewCell

@property(nonatomic,strong)LYSPageMenuModel * item;

@property(nonatomic,copy)void(^ImageLoader)(NSString *imageUrl,UIImageView *menuIcon);


@end
