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
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aImageV;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageV;
@property (weak, nonatomic) IBOutlet UIButton *aBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initUI];
    
    //去网络上下载新的主题
    [[WZThemeManger manger] downloadThemeFrom:@"https://github.com/hwzss/WZTheme/raw/master/theme.zip" themeName:@"github上新的主题"];
    
}

- (void)initUI
{
    //通过主题的UI方法设置UI，这样在新的主题被设置时这些方法将自动被调用一次已重新设置主题
    [self.aImageV wz_setImageWithName:@"电费@3x"];
    [self.secondImageV wz_setImageWithName:@"主题云钥匙选中状态@3x"];
    [self.aBtn wz_setImageWithName:@"主题云钥匙选中状态@3x" forState:UIControlStateNormal];
    [self.aBtn wz_setImageWithName:@"电费@3x" forState:UIControlStateSelected];
    [self.view wz_setBackgroundColorWithName:@"ThemeBackColor"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (IBAction)buttonAction:(id)sender
{
    self.aBtn.selected = !self.aBtn.selected;
}

- (void)pushAction
{
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[WZThemeManger manger] useDefaultTheme];
}


@end
