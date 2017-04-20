//
//  LYSPageMenu.m
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPageMenu.h"
#import "LYSPageMenuCell.h"

@interface LYSPageMenu ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * listView;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,copy)NSArray<NSArray<LYSPageMenuModel*> *> * data;

@end

@implementation LYSPageMenu


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

#pragma mark - 列表视图
-(UICollectionView *)listView{
    if (!_listView) {
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _listView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), self.row * self.itemH) collectionViewLayout:flowLayout];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.pagingEnabled = YES;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        [_listView registerClass:[LYSPageMenuCell class] forCellWithReuseIdentifier:NSStringFromClass([LYSPageMenuCell class])];
    }
    return _listView;
}

#pragma mark - 分页
-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.listView.frame), CGRectGetWidth(self.frame), self.pageH)];
        _pageControl.pageIndicatorTintColor = self.normalPageColor;
        _pageControl.currentPageIndicatorTintColor = self.selectedPageColor;
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

#pragma mark - 重写layoutSubviews方法
-(void)layoutSubviews{
    [super layoutSubviews];
    self.listView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.row * self.itemH);
    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.listView.frame), CGRectGetWidth(self.frame), self.pageH);
}

#pragma mark - 按钮被点击
-(void)pageChanged:(UIPageControl*)sender{
    NSUInteger currentPage = sender.currentPage;
    CGPoint contentOffset = self.listView.contentOffset;
    contentOffset.x = currentPage * self.bounds.size.width;
    [self.listView setContentOffset:contentOffset animated:YES];
}

#pragma mark - 初始化配置
-(void)initConfig{
    self.clipsToBounds = YES;
    [self setDefaults];
    [self addSubview:self.listView];
    [self addSubview:self.pageControl];
    [self updateItems];
}

#pragma mark - 设置默认
-(void)setDefaults{
    _itemH = 60.f;
    _pageH = 20.f;
    _row = 2;
    _normalPageColor = [self colorWithHexString:@"e3e2e2" alpha:1.0];
    _selectedPageColor = [self colorWithHexString:@"1686D5" alpha:1.0];
    _column = 4;
}

-(void)setItemH:(CGFloat)itemH{
    _itemH = itemH;
    [self updateSelfFrame];
}

-(void)setRow:(NSUInteger)row{
    _row = row;
    [self updateItems];
}

-(void)setColumn:(NSUInteger)column{
    _column = column;
    [self updateItems];
}

-(void)setNormalPageColor:(UIColor *)normalPageColor{
    _normalPageColor = normalPageColor;
    self.pageControl.pageIndicatorTintColor = self.normalPageColor;
}

-(void)setSelectedPageColor:(UIColor *)selectedPageColor{
    _selectedPageColor = selectedPageColor;
    self.pageControl.currentPageIndicatorTintColor = self.selectedPageColor;
}

#pragma mark - 更新frame
-(void)updateSelfFrame{
    CGRect selfFrame = self.frame;
    if(self.items.count > 0){
        selfFrame.size.height = self.row * self.itemH + self.pageH;
    }else{
        selfFrame.size.height = 0;
    }
    self.frame = selfFrame;
}

#pragma mark - 总页数
-(NSUInteger)pages{
    if (self.items.count % (self.column * self.row) == 0){
        return self.items.count / (self.column * self.row);
    }else{
        return self.items.count / (self.column * self.row) + 1;
    }
}

#pragma mark - 设置items
-(void)setItems:(NSArray<LYSPageMenuModel *> *)items{
    _items = [items sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        LYSPageMenuModel * firstItem = (LYSPageMenuModel*)obj1;
        LYSPageMenuModel * secondItem = (LYSPageMenuModel*)obj2;
        if (firstItem.rank > secondItem.rank) {
            return NSOrderedDescending;
        }else if(firstItem.rank < secondItem.rank){
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
    self.pageControl.numberOfPages = [self pages];
    [self updateItems];
}

-(void)updateItems{
    NSMutableArray<LYSPageMenuModel*> * singleItems = [NSMutableArray array];
    NSMutableArray * result = [NSMutableArray array];
    __weak typeof (self)MyWeakSelf = self;
    [self.items enumerateObjectsUsingBlock:^(LYSPageMenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [singleItems addObject:obj];
        if (idx != 0 && (idx + 1) % (MyWeakSelf.row * MyWeakSelf.column) == 0) {
            [result addObject:[singleItems copy]];
            [singleItems removeAllObjects];
        }else{
            if (idx == MyWeakSelf.items.count - 1) {
                [result addObject:[singleItems copy]];
            }
        }
    }];
    self.data = [NSArray arrayWithArray:result];
    [self.listView reloadData];
    [self updateSelfFrame];
}

#pragma mark - UICollectionViewDataSource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self pages];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYSPageMenuCell *_cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LYSPageMenuCell class]) forIndexPath:indexPath];
    _cell.row = self.row;
    _cell.column = self.column;
    _cell.ImageLoader = self.ImageLoader;
    _cell.item = [self.data objectAtIndex:indexPath.row];
    _cell.ItemSelectedBlock = self.ItemSelectedBlock;
    return _cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.width, self.itemH * self.row);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
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

@end
