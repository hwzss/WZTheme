//
//  ViewController.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WZTheme.h"
#import "WZThemeManger.h"
#import "UIView+WZTheme.h"
#import "UIButton+WZTheme.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aImageV;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageV;
@property (weak, nonatomic) IBOutlet UIButton *aBtn;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.aImageV wz_setImageWithName:@"电费@3x"];
    [self.secondImageV wz_setImageWithName:@"主题云钥匙选中状态@3x"];
    [self.aBtn wz_setImageWithName:@"主题云钥匙选中状态@3x" forState:UIControlStateNormal];
    
    [self.view wz_setThemeBackgroundColorWithName:@"ThemeBackColor"];
    
    //去网络上下载新的主题
    [[WZThemeManger manger] downloadThemeFrom:@"https://github.com/hwzss/WZTheme/raw/master/theme.zip" themeName:@"github上新的主题"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[WZThemeManger manger] useDefaultTheme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
