//
//  ViewController.m
//  LYSPageMenu
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPageMenu.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property(nonatomic,strong)LYSPageMenu * pageMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pageMenu];
    self.pageMenu.backgroundColor = [UIColor whiteColor];
    LYSPageMenuModel * model = [LYSPageMenuModel new];
    model.menuIcon = @"bill_charge_icon";
    model.rank = 3;
    model.enabled = YES;
    model.menuTitle = @"账单缴费1";
    LYSPageMenuModel * model1 = [LYSPageMenuModel new];
    model1.menuIcon = @"ic_card_buy_icon";
    model1.rank = 1;
    model1.enabled = YES;
    model1.menuTitle = @"账单缴费2";
    LYSPageMenuModel * model2 = [LYSPageMenuModel new];
    model2.menuIcon = @"online_service_icon";
    model2.rank = 1;
    model2.enabled = YES;
    model2.menuTitle = @"账单缴费3";
    LYSPageMenuModel * model3 = [LYSPageMenuModel new];
    model3.menuIcon = @"helper_menu_icon";
    model3.rank = 1;
    model3.enabled = YES;
    model3.menuTitle = @"账单缴费4";
    LYSPageMenuModel * model4 = [LYSPageMenuModel new];
    model4.menuIcon = @"consult_icon";
    model4.rank = 1;
    model4.enabled = YES;
    model4.menuTitle = @"账单缴费5";
    LYSPageMenuModel * model5 = [LYSPageMenuModel new];
    model5.menuIcon = @"bind_table_icon";
    model5.rank = 1;
    model5.enabled = YES;
    model5.menuTitle = @"账单缴费6";
    LYSPageMenuModel * model6 = [LYSPageMenuModel new];
    model6.menuIcon = @"bill_charge_icon";
    model6.rank = 1;
    model6.enabled = YES;
    model6.menuTitle = @"账单缴费7";
    LYSPageMenuModel * model7 = [LYSPageMenuModel new];
    model7.menuIcon = @"bill_charge_icon";
    model7.rank = 1;
    model7.enabled = YES;
    model7.menuTitle = @"账单缴费8";
    LYSPageMenuModel * model8 = [LYSPageMenuModel new];
    model8.menuIcon = @"http://jk-img-user.jkepay.com/3131ef3b3ec9a988136a026be8bd6a70_20160819145326.png";
    model8.rank = 0;
    model8.enabled = YES;
    model8.menuTitle = @"账单缴费9";
    self.pageMenu.items = @[model,model1,model2,model3,model4,model5,model6,model7,model8];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LYSPageMenu*)pageMenu{
    if (!_pageMenu) {
        _pageMenu = [[LYSPageMenu alloc]initWithFrame:CGRectMake(0, 120, CGRectGetWidth(self.view.frame), 0)];
        _pageMenu.column = 4;
        _pageMenu.row = 2;
        _pageMenu.ImageLoader = ^(NSString *imageUrl,UIImageView *menuIcon){
            NSLog(@"%@",imageUrl);
            if ([imageUrl hasPrefix:@"http"]) {
                [menuIcon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_menu_icon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];

            }else{
                menuIcon.image = [UIImage imageNamed:imageUrl];
            }
        };
        _pageMenu.ItemSelectedBlock = ^(LYSPageMenuModel *item){
            NSLog(@"%@",item.menuTitle);
        };
        _pageMenu.itemH = 100.f;
    }
    return _pageMenu;
}

@end
