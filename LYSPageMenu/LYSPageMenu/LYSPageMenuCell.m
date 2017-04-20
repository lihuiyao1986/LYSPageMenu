//
//  LYSPageMenuCell.m
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPageMenuCell.h"
#import "LYSPageMenuItemCell.h"

@interface  LYSPageMenuCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *listView;

@end

@implementation LYSPageMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)setItem:(NSArray<LYSPageMenuModel *> *)item{
    _item = item;
    [self.listView reloadData];
}

-(void)initConfig{
    [self.contentView addSubview:self.listView];
}

#pragma mark - 列表视图
-(UICollectionView *)listView{
    if (!_listView) {
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _listView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.pagingEnabled = YES;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        [_listView registerClass:[LYSPageMenuItemCell class] forCellWithReuseIdentifier:NSStringFromClass([LYSPageMenuItemCell class])];
        
    }
    return _listView;
}

#pragma mark - UICollectionViewDataSource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.item.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYSPageMenuItemCell *_cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LYSPageMenuItemCell class]) forIndexPath:indexPath];
    _cell.ImageLoader = self.ImageLoader;
    _cell.item = [self.item objectAtIndex:indexPath.row];
    return _cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake(floor(self.bounds.size.width / self.column), self.bounds.size.height / self.row);
    return itemSize;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ItemSelectedBlock) {
        self.ItemSelectedBlock(self.item[indexPath.row]);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.listView.frame = self.bounds;
}
@end
