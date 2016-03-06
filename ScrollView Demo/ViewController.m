//
//  ViewController.m
//  ScrollView Demo
//
//  Created by ljw on 16/3/3.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "ViewController.h"
#import "JWPageView.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    JWPageView *pageView = [JWPageView pageViews];
    
//    pageView.frame = CGRectMake(10, 10, 500, 500);
    //图片名数组
    pageView.imageArray = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    
    [self.view addSubview:pageView];
    
    //pageView约束
    [pageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(pageView.frame.size.height);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
